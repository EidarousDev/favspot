import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../repositories/file_system_repo.dart';

class PickVideoUseCase extends UseCase<XFile?, NoParams> {
  final FileSystemRepo filePickerRepo;

  PickVideoUseCase(this.filePickerRepo);
  @override
  Future<Either<Failure, XFile?>> call(NoParams params) async {
    return await filePickerRepo.pickVideo();
  }
}
