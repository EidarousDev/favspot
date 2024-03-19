import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../repositories/file_system_repo.dart';

class PickImagesUseCase extends UseCase<List<XFile?>, NoParams> {
  final FileSystemRepo filePickerRepo;

  PickImagesUseCase(this.filePickerRepo);
  @override
  Future<Either<Failure, List<XFile?>>> call(NoParams params) async {
    return await filePickerRepo.pickImages();
  }
}
