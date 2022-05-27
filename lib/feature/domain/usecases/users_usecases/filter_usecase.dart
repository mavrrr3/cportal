import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_filter_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FetchFiltersUseCase {
  final IFilterRepository filterRepository;

  FetchFiltersUseCase(this.filterRepository);

  Future<Either<Failure, List<FilterEntity>>> call() async =>
      filterRepository.fetchFilters();
}

class FetchFiltersParams extends Equatable {
  final String endPoint;

  const FetchFiltersParams({required this.endPoint});
  @override
  List<Object?> get props => [endPoint];
}
