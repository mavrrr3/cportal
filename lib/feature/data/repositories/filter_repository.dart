import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/platform/i_network_info.dart';
import 'package:cportal_flutter/feature/data/datasources/filter_datasource/filter_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/filter_datasource/filter_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/filter_model.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_filter_repository.dart';
import 'package:dartz/dartz.dart';

class FilterRepository implements IFilterRepository {
  final IFilterRemoteDataSource remoteDataSource;
  final IFilterLocalDataSource localDataSource;
  final INetworkInfo networkInfo;

  FilterRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<FilterModel>>> fetchFilters() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteFilters = await remoteDataSource.fetchFilters();

        return Right(remoteFilters);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localFilters = await localDataSource.fetchFiltersFromCache();

        return Right(localFilters);
      } on CacheFailure {
        return Left(CacheFailure());
      }
    }
  }
}
