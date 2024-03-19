import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/failures.dart';
import '../../domain/repositories/file_system_repo.dart';
import '../data_sources/file_system_data_source.dart';

class FileSystemRepoImpl implements FileSystemRepo {
  final FileSystemDataSource filePickerDataSource;

  FileSystemRepoImpl(this.filePickerDataSource);

  @override
  Future<Either<Failure, void>> downloadFile(String url) async {
    try {
      await filePickerDataSource.downloadFile(url);
      return const Right(null);
    } catch (ex) {
      return Left(ReadFileFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, XFile?>> pickImage() async {
    try {
      final image = await filePickerDataSource.pickImage();
      return Right(image);
    } catch (ex) {
      return Left(ReadFileFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, List<XFile?>>> pickImages() async {
    try {
      return Right(await filePickerDataSource.pickImages());
    } catch (ex) {
      return Left(ReadFileFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, XFile?>> pickVideo() async {
    try {
      final video = await filePickerDataSource.pickVideo();
      return Right(video);
    } catch (ex) {
      return Left(ReadFileFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadCheckInPhoto(File image) async {
    try {
      final url = await filePickerDataSource.uploadCheckInPhoto(image);
      return Right(url);
    } catch (ex) {
      return Left(HttpFailure(message: ex.toString()));
    }
  }
}
