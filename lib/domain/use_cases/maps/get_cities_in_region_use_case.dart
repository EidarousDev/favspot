import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../entities/city_entity.dart';
import '../../repositories/maps_repo.dart';

class GetCitiesInRegionUseCase extends UseCase<List<CityEntity>, CitiesParams> {
  final MapsRepo mapsRepo;

  GetCitiesInRegionUseCase(this.mapsRepo);

  @override
  Future<Either<Failure, List<CityEntity>>> call(params) async {
    return await mapsRepo.getCitiesInRegion(params.region);
  }
}
