import 'package:cportal_flutter/feature/domain/entities/main_search_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_main_search_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/usecases/i_usecase.dart';

class MainSearchUseCase
    extends IUseCase<List<MainSearchEntity>, MainSearchParams> {
  final IMainSearchRepository mainSearchRepository;

  MainSearchUseCase(this.mainSearchRepository);

  @override
  Future<Either<Failure, List<MainSearchEntity>>> call(
    MainSearchParams params,
  ) async =>
      mainSearchRepository.search(params.query);
}

class MainSearchParams extends Equatable {
  final String query;

  const MainSearchParams({required this.query});
  @override
  List<Object?> get props => [query];
}
