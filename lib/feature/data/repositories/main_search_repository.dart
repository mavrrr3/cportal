import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_main_search_remote_datasource.dart';
import 'package:cportal_flutter/feature/domain/entities/main_search_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_main_search_repository.dart';
import 'package:dartz/dartz.dart';

class MainSearchRepository implements IMainSearchRepository {
  final IMainSearchRemoteDataSource remoteDataSource;

  MainSearchRepository({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<MainSearchEntity>>> search(String query) async {
    try {
      final result = await remoteDataSource.search(query);

      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
