import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/main_search_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_main_search_repository.dart';
import 'package:dartz/dartz.dart';

class MainSearchGetFromMemoryUseCase {
  final IMainSearchRepository mainSearchRepository;

  MainSearchGetFromMemoryUseCase(this.mainSearchRepository);

  Future<Either<Failure, List<MainSearchEntity>?>> call() async =>
      mainSearchRepository.getMainSearchFromMemory();
}
