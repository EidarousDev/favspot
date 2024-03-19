import 'dart:io';

import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../../../core/utils/helper_functions.dart';
import '../../core/config/firestore_config.dart';
import 'common_data_source.dart';

abstract class FileSystemDataSource {
  Future<XFile?> pickImage();
  Future<List<XFile?>> pickImages();
  Future<XFile?> pickVideo();
  Future<void> downloadFile(String url);
  Future<String> uploadCheckInPhoto(File image);
}

class FileSystemDataSourceImpl implements FileSystemDataSource {
  final ImagePicker imagePicker;

  FileSystemDataSourceImpl(this.imagePicker);

  @override
  Future<XFile?> pickImage() async {
    return await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 25);
  }

  @override
  Future<XFile?> pickVideo() async {
    return await imagePicker.pickVideo(source: ImageSource.gallery);
  }

  @override
  Future<void> downloadFile(String url) async {
    Response response = await get(Uri.parse(url));
    var firstPath = '/sdcard/download/';
    String name =
        '${Helper.randomAlphaNumeric(20)}.${response.headers['content-type'].toString().split('/')[1]}';
    var filePathAndName = firstPath + name;
    File file = File(filePathAndName);
    file.writeAsBytesSync(response.bodyBytes);
  }

  @override
  Future<List<XFile?>> pickImages() async {
    return await imagePicker.pickMultiImage();
  }

  @override
  Future<String> uploadCheckInPhoto(File image) async {
    return await CommonDataSource.uploadFile(
        file: image, path: '${StoragePaths.checkIns}/${basename(image.path)}');
  }
}
