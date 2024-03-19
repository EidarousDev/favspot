import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favspot/core/use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../core/config/maps_config.dart';
import '../core/config/translation_keys.dart';
import '../domain/entities/beach_entity.dart';
import '../domain/entities/city_entity.dart';
import '../domain/entities/region_entity.dart';
import '../domain/use_cases/maps/get_beaches_use_case.dart';
import '../domain/use_cases/maps/get_cities_in_region_use_case.dart';
import '../domain/use_cases/maps/get_regions_use_case.dart';

class MapsProvider extends ChangeNotifier {
  final GetBeachesUseCase getBeachesUseCase;
  final GetRegionsUseCase getRegionsUseCase;
  final GetCitiesInRegionUseCase getCitiesInRegionUseCase;
  MapsProvider(
      {required this.getBeachesUseCase,
      required this.getRegionsUseCase,
      required this.getCitiesInRegionUseCase});

  // Private State
  Set<Marker> _markers = {};
  Set<Marker> _cachedMarkers = {};
  List<RegionEntity> _regions = [];
  List<BeachEntity> _cachedBeaches = [];
  List<BeachEntity> _searchedBeaches = [];
  List<CityEntity> _cities = [];
  RegionEntity? _selectedRegion;
  CityEntity? _selectedCity;
  GoogleMapController? _controller;
  double? _latitude;
  double? _longitude;

  // Getters
  Set<Marker> get markers => _markers;
  GoogleMapController? get controller => _controller;
  UnmodifiableListView<RegionEntity> get regions =>
      UnmodifiableListView(_regions);
  UnmodifiableListView<BeachEntity> get cachedBeaches =>
      UnmodifiableListView(_cachedBeaches);
  UnmodifiableListView<CityEntity> get cities => UnmodifiableListView(_cities);
  UnmodifiableListView<BeachEntity> get searchedBeaches =>
      UnmodifiableListView(_searchedBeaches);
  RegionEntity? get selectedRegion => _selectedRegion;
  CityEntity? get selectedCity => _selectedCity;
  double? get latitude => _latitude;
  double? get longitude => _longitude;

  // Setters
  void setLatLng(double? lat, double? long) {
    _latitude = lat;
    _longitude = long;
    notifyListeners();
  }

  void setMapsController(GoogleMapController controller) {
    debugPrint('====== setMapsController ======');
    debugPrint('====== $_latitude ======');
    debugPrint('====== $_longitude ======');
    _controller = controller;
    LatLng newLatLang = LatLng(_latitude ?? MapsConfig.defaultLat,
        _longitude ?? MapsConfig.defaultLong);
    _controller?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: newLatLang, zoom: 11)
        //17 is new zoom level
        ));
    //notifyListeners();
  }

  void setSelectedRegion(RegionEntity? region) {
    _selectedRegion = region;
    notifyListeners();
  }

  void setSelectedCity(CityEntity? city) {
    _selectedCity = city;
    notifyListeners();
  }

  // Methods
  void getBeaches({required Function(BeachEntity beachEntity) onTap}) async {
    if (_markers.isNotEmpty) {
      return;
    }
    final result = await getBeachesUseCase(NoParams());
    result.fold((l) => debugPrint('Failed to get Beaches'), (beaches) {
      _cachedBeaches = beaches;
      beaches.forEach((beach) {
        GeoPoint tmp = beach.location;
        final MarkerId markerId = MarkerId(beach.place);
        LatLng point = LatLng(tmp.latitude, tmp.longitude);
        final Marker marker = Marker(
          markerId: markerId,
          position: point,
          infoWindow: InfoWindow(
            title: beach.place + " | " + beach.status,
            onTap: () {
              onTap(beach);
              // Navigate to BeachDetailScreen();
            },
          ),
          icon: markerIcon(beach.status),
        );
        _markers.add(marker);
      });
      debugPrint('_markers');
      debugPrint('$_markers');
    });
    notifyListeners();
  }

  void filterBeaches(String status) {
    if (status == S.clearFilter && _cachedMarkers.isEmpty) {
      // do nothing
      return;
    } else if (status == S.clearFilter && _cachedMarkers.isNotEmpty) {
      if (_markers != _cachedMarkers) {
        _markers = _cachedMarkers;
      }
    } else if (_cachedMarkers.isEmpty) {
      _cachedMarkers = _markers;
      _markers = _markers
          .where((element) => element.infoWindow.title!.contains(status))
          .toSet();
    } else {
      if (_cachedMarkers.isNotEmpty) {
        _markers = _cachedMarkers
            .where((element) => element.infoWindow.title!.contains(status))
            .toSet();
      }
    }
    notifyListeners();
  }

  void searchBeaches(String query) async {
    _searchedBeaches = await _cachedBeaches
        .where(
            (beach) => beach.place.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void clearSearch() {
    _searchedBeaches = [];
    notifyListeners();
  }

  void getRegions() async {
    final result = await getRegionsUseCase(NoParams());
    result.fold((l) => null, (regions) {
      debugPrint('Regions = $regions');
      _regions = regions;
      // if (_selectedRegion == null && regions.isNotEmpty) {
      //   _selectedRegion = regions[0];
      // }
      notifyListeners();
    });
  }

  void animateMapsCamera() {
    debugPrint('==== animateMapsCamera ====');
    debugPrint('$selectedRegion');
    if (_latitude == null || _longitude == null) {
      return;
    }
    LatLng newLatLang = LatLng(_latitude!, _longitude!);
    _controller?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: newLatLang, zoom: 11)));
    notifyListeners();
  }

  BitmapDescriptor markerIcon(String status) {
    switch (status) {
      case 'Free':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
      case 'Low':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      case 'Moderate':
        return BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueYellow);
      case 'Abundant':
        return BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange);
      default:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }
  }

  void getCitiesInRegion() async {
    if (selectedRegion == null) return;
    EasyLoading.show();
    final result = await getCitiesInRegionUseCase(
        CitiesParams(region: selectedRegion!.region));
    result.fold((l) => null, (cities) {
      debugPrint('Cities = $cities');
      _cities = cities;
      _selectedCity = null;
      notifyListeners();
    });
    EasyLoading.dismiss();
  }
}
