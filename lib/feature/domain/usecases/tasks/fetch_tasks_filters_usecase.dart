import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_filter_repository.dart';
import 'package:dartz/dartz.dart';

class FetchTasksFiltersUseCase {
  final IFilterRepository filterRepository;

  FetchTasksFiltersUseCase(this.filterRepository);

  Future<Either<Failure, FilterResponseEntity>> call() async =>
      filterRepository.fetchTasksFilters();
}
