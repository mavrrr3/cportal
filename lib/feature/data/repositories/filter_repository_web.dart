import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/datasources/filter_datasource/filter_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/filter_model.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_filter_repository.dart';
import 'package:dartz/dartz.dart';

class FilterRepositoryWeb implements IFilterRepository {
  final IFilterRemoteDataSource remoteDataSource;

  FilterRepositoryWeb({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<FilterModel>>> fetchFilters() async {
    try {
      final remoteFilters = await remoteDataSource.fetchFilters();

      return Right(remoteFilters);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
