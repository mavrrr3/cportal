import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/main_search_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_main_search_repository.dart';
import 'package:dartz/dartz.dart';

class MainSearchAddToMemoryUseCase {
  final IMainSearchRepository mainSearchRepository;

  MainSearchAddToMemoryUseCase(this.mainSearchRepository);

  Future<Either<Failure, void>> call(
    MainSearchEntity mainsearch,
  ) async =>
      mainSearchRepository.addMainSearchToMemory(mainsearch);
}
