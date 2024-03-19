import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../entities/region_entity.dart';
import '../../repositories/maps_repo.dart';

class GetRegionsUseCase extends UseCase<List<RegionEntity>, NoParams> {
  final MapsRepo mapsRepo;

  GetRegionsUseCase(this.mapsRepo);

  @override
  Future<Either<Failure, List<RegionEntity>>> call(params) async {
    return await mapsRepo.getRegions();
  }
}
