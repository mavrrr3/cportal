import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_filter_repository.dart';
import 'package:dartz/dartz.dart';

class FetchDeclarationsFiltersUseCase {
  final IFilterRepository filterRepository;

  FetchDeclarationsFiltersUseCase(this.filterRepository);

  Future<Either<Failure, FilterResponseEntity>> call() async =>
      filterRepository.fetchDeclarationsFilters();
}
