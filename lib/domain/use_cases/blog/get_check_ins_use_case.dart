import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../entities/check_in_entity.dart';
import '../../repositories/blog_repo.dart';

class GetCheckInsUseCase extends UseCase<List<CheckInEntity>, BlogParams> {
  final BlogRepo blogRepo;

  GetCheckInsUseCase(this.blogRepo);
  @override
  Future<Either<Failure, List<CheckInEntity>>> call(BlogParams params) async {
    return await blogRepo.getCheckIns(startAfter: params.startAfter);
  }
}
