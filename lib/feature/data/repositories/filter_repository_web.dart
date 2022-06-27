import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/datasources/filter_datasource/filter_remote_datasource.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_filter_repository.dart';
import 'package:dartz/dartz.dart';

class FilterRepositoryWeb implements IFilterRepository {
  final IFilterRemoteDataSource remoteDataSource;

  FilterRepositoryWeb({required this.remoteDataSource});

  @override
  Future<Either<Failure, FilterResponseEntity>> fetchContactsFilters() async {
    try {
      final remoteFilters = await remoteDataSource.fetchContactsFilters();

      return Right(remoteFilters);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, FilterResponseEntity>> fetchDeclarationsFilters() async {
    try {
      final remoteFilters = await remoteDataSource.fetchDeclarationsFilters();

      return Right(remoteFilters);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
