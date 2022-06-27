import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/platform/i_network_info.dart';
import 'package:cportal_flutter/feature/data/datasources/filter_datasource/filter_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/filter_datasource/filter_remote_datasource.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_filter_repository.dart';
import 'package:dartz/dartz.dart';

class FilterRepositoryMobile implements IFilterRepository {
  final IFilterRemoteDataSource remoteDataSource;
  final IFilterLocalDataSource localDataSource;
  final INetworkInfo networkInfo;

  FilterRepositoryMobile({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, FilterResponseEntity>> fetchContactsFilters() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteFilters = await remoteDataSource.fetchContactsFilters();

        return Right(remoteFilters);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localFilters = await localDataSource.fetchFiltersFromCache(FilterType.contacts);

        return Right(localFilters);
      } on CacheFailure {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, FilterResponseEntity>> fetchDeclarationsFilters() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteFilters = await remoteDataSource.fetchDeclarationsFilters();

        return Right(remoteFilters);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localFilters = await localDataSource.fetchFiltersFromCache(FilterType.declarations);

        return Right(localFilters);
      } on CacheFailure {
        return Left(CacheFailure());
      }
    }
  }
}
