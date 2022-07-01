import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/usecases/i_usecase.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_filter_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FetchContactsFiltersUseCase extends IUseCase<FilterResponseEntity, FetchFiltersParams> {
  final IFilterRepository filterRepository;

  FetchContactsFiltersUseCase(this.filterRepository);

  @override
  Future<Either<Failure, FilterResponseEntity>> call(FetchFiltersParams params) async =>
      filterRepository.fetchContactsFilters();
}

class FetchFiltersParams extends Equatable {
  @override
  List<Object?> get props => [];
}
