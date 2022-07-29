import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/main_search_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IMainSearchRepository {
  Future<Either<Failure, List<MainSearchEntity>>> search(String query);
  Future<Either<Failure, void>> addMainSearchToMemory(
    MainSearchEntity mainsearch,
  );
  Future<Either<Failure, List<MainSearchEntity>?>> getMainSearchFromMemory();
}
