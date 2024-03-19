import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../repositories/file_system_repo.dart';

class DownloadFileUseCase extends UseCase<void, DownloadFileParams> {
  final FileSystemRepo fileSystemRepo;

  DownloadFileUseCase(this.fileSystemRepo);
  @override
  Future<Either<Failure, void>> call(DownloadFileParams params) async {
    return await fileSystemRepo.downloadFile(params.url);
  }
}
