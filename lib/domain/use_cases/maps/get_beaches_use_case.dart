import 'package:dartz/dartz.dart';
import 'package:favspot/core/failures.dart';

import '../../../core/use_case.dart';
import '../../entities/beach_entity.dart';
import '../../repositories/maps_repo.dart';

class GetBeachesUseCase extends UseCase<List<BeachEntity>, NoParams> {
  final MapsRepo mapsRepo;

  GetBeachesUseCase(this.mapsRepo);

  @override
  Future<Either<Failure, List<BeachEntity>>> call(NoParams params) async {
    return await mapsRepo.getBeaches();
  }
}
