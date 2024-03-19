import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/failures.dart';

abstract class FileSystemRepo {
  Future<Either<Failure, XFile?>> pickImage();
  Future<Either<Failure, List<XFile?>>> pickImages();
  Future<Either<Failure, XFile?>> pickVideo();
  Future<Either<Failure, void>> downloadFile(String url);
  Future<Either<Failure, String>> uploadCheckInPhoto(File image);
}
