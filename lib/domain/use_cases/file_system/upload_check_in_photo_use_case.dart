import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../repositories/file_system_repo.dart';

class UploadCheckInPhotoUseCase extends UseCase<String, UploadFileParams> {
  final FileSystemRepo filePickerRepo;

  UploadCheckInPhotoUseCase(this.filePickerRepo);
  @override
  Future<Either<Failure, String>> call(UploadFileParams params) async {
    return await filePickerRepo.uploadCheckInPhoto(params.file);
  }
}
