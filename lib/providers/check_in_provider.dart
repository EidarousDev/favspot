import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../core/config/app_config.dart';
import '../core/config/firestore_config.dart';
import '../core/errors.dart';
import '../core/use_case.dart';
import '../data/models/check_in_model.dart';
import '../domain/entities/beach_entity.dart';
import '../domain/entities/city_entity.dart';
import '../domain/entities/region_entity.dart';
import '../domain/use_cases/check_in/create_check_in_use_case.dart';
import '../domain/use_cases/check_in/notify_admin_by_email_use_case.dart';
import '../domain/use_cases/file_system/pick_image_use_case.dart';
import '../domain/use_cases/file_system/upload_check_in_photo_use_case.dart';
import '../domain/use_cases/maps/get_cities_in_region_use_case.dart';

class CheckInProvider extends ChangeNotifier {
  final GetCitiesInRegionUseCase getCitiesInRegionUseCase;
  final PickImageUseCase pickImageUseCase;
  final UploadCheckInPhotoUseCase uploadCheckInPhotoUseCase;
  final CreateCheckInUseCase createCheckInUseCase;
  final NotifyAdminByEmailUseCase notifyAdminByEmailUseCase;

  CheckInProvider(
      {required this.getCitiesInRegionUseCase,
      required this.pickImageUseCase,
      required this.uploadCheckInPhotoUseCase,
      required this.createCheckInUseCase,
      required this.notifyAdminByEmailUseCase});

  // Private State
  List<RegionEntity> _regions = [];
  List<BeachEntity> _beaches = [];
  List<BeachEntity> _cachedBeaches = [];
  List<CityEntity> _cities = [];
  List<Status> _statuses = [];
  RegionEntity? _selectedRegion;
  CityEntity? _selectedCity;
  BeachEntity? _selectedBeach;
  Status? _selectedStatus;
  XFile? _image;
  String _error = '';

  // Getters
  List<RegionEntity> get regions => _regions;
  List<BeachEntity> get beaches => _beaches;
  List<CityEntity> get cities => _cities;
  List<Status> get statuses => _statuses;
  RegionEntity? get selectedRegion => _selectedRegion;
  CityEntity? get selectedCity => _selectedCity;
  BeachEntity? get selectedBeach => _selectedBeach;
  Status? get selectedStatus => _selectedStatus;
  XFile? get image => _image;
  String get error => _error;

  // Setters
  void setRegions(List<RegionEntity> regions) {
    _regions = regions;
    notifyListeners();
  }

  void setCachedBeaches(List<BeachEntity> beaches) {
    _cachedBeaches = beaches;
    notifyListeners();
  }

  void setBeaches(List<BeachEntity> beaches) {
    _beaches = beaches;
    notifyListeners();
  }

  void setStatuses() {
    _statuses = kBeachesStatuses;
    notifyListeners();
  }

  void setSelectedRegion(RegionEntity? region) {
    _selectedRegion = region;
    notifyListeners();
  }

  void setSelectedCity(CityEntity? city) {
    _selectedCity = city;
    notifyListeners();
  }

  void setSelectedBeach(BeachEntity? beach) {
    _selectedBeach = beach;
    notifyListeners();
  }

  void setSelectedStatus(Status? status) {
    _selectedStatus = status;
    notifyListeners();
  }

  // Methods
  void getCitiesInRegion() async {
    if (selectedRegion == null) return;
    EasyLoading.show();
    final result = await getCitiesInRegionUseCase(
        CitiesParams(region: selectedRegion!.region));
    result.fold((l) => null, (cities) {
      debugPrint('Cities = $cities');
      _cities = cities;
      notifyListeners();
    });
    EasyLoading.dismiss();
  }

  void filterBeachesByCity(String city) {
    _beaches = [];
    if (_cachedBeaches.isEmpty) {
      _cachedBeaches = _beaches;
      _beaches = _beaches
          .where((element) => element.city.toUpperCase() == city.toUpperCase())
          .toList();
    } else {
      _beaches = _cachedBeaches
          .where((element) => element.city.toUpperCase() == city.toUpperCase())
          .toList();
    }
    debugPrint('CachedBeaches = ${_cachedBeaches}');
    notifyListeners();
  }

  void selectImage() async {
    EasyLoading.show();
    final result = await pickImageUseCase(NoParams());
    result.fold((l) => debugPrint('PickImageError: ${l.message}'),
        (pickedImage) => _image = pickedImage);
    notifyListeners();
    EasyLoading.dismiss();
  }

  void formValidation(
      {required String userName,
      required Function onSuccess,
      required Function onError}) async {
    EasyLoading.show();
    _error = ''; // Reset the error
    String? _imageUrl;
    if (_selectedRegion == null ||
        _selectedCity == null ||
        _selectedBeach == null ||
        _selectedStatus == null) {
      _error = Errors.missingFields;
      // Show Error Dialog
      onError();
    } else {
      // Validation Passed
      if (_image != null) {
        // Image is Optional
        final uploadResult = await uploadCheckInPhotoUseCase(
            UploadFileParams(File(_image!.path)));
        uploadResult.fold((l) {
          _error = Errors.uploadFailed;
          // Show Error Dialog
          onError();
          return;
        }, (url) => _imageUrl = url);
      }
      // Create the document on Firestore
      CheckInModel model = CheckInModel(
          region: _selectedRegion!.region,
          city: _selectedCity!.name,
          place: _selectedBeach!.place,
          status: _selectedStatus!.status,
          userName: userName,
          userId: AppConfig.uid,
          imageUrl: _imageUrl);
      final createResult =
          await createCheckInUseCase(CheckInParams(checkInModel: model));
      createResult.fold((l) {
        _error = Errors.createDocumentFailed;
        // Show Error Dialog
        EasyLoading.dismiss();
        onError();
        return;
      }, (r) async {
        await notifyAdminByEmailUseCase(NotifyAdminParams(
            message:
                'Region: ${_selectedRegion!.region} | City: ${_selectedCity!.name} | Place: ${_selectedBeach!.place} | Status: ${_selectedStatus!.status} | User: $userName | UserID: ${AppConfig.uid}'));
      });
      if (_error.length == 0) {
        // Show Success Dialog
        onSuccess();
      }
    }
    EasyLoading.dismiss();
  }

  void reset() {
    _selectedRegion = null;
    _selectedStatus = null;
    _selectedCity = null;
    _selectedBeach = null;
    _image = null;
    _error = '';
    notifyListeners();
  }
}
