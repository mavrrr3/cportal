import 'package:cportal_flutter/core/error/cache_exception.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_main_search_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_main_search_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/main_search_model.dart';
import 'package:cportal_flutter/feature/domain/entities/main_search_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_main_search_repository.dart';

import 'package:dartz/dartz.dart';

class MainSearchRepository implements IMainSearchRepository {
  final IMainSearchRemoteDataSource remoteDataSource;
  final IMainSearchLocalDataSource localDataSource;

  MainSearchRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<MainSearchModel>>> search(String query) async {
    try {
      final result = await remoteDataSource.search(query);

      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addMainSearchToMemory(
    MainSearchEntity mainsearch,
  ) async {
    try {
      final result = await localDataSource.addMainSearchToMemory(mainsearch);

      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<MainSearchModel>?>>
      getMainSearchFromMemory() async {
    try {
      final result = await localDataSource.getMainSearchFromMemory();

      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
