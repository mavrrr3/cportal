import 'package:cportal_flutter/core/error/exception.dart';
import 'package:cportal_flutter/core/platform/network_info.dart';
import 'package:cportal_flutter/data/datasources/profile_datasource/profile_local_datasource.dart';
import 'package:cportal_flutter/data/datasources/profile_datasource/profile_remote_datasource.dart';

import 'package:cportal_flutter/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/domain/repositories/i_profile_repository.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryImpl implements IProfileRepository {
  final IProfileRemoteDataSource remoteDataSource;
  final IProfileLocalDataSource localDataSource;
  final INetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProfileEntity>> getSingleProfile(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await remoteDataSource.getSingleProfile(id);

        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localeUser = await localDataSource.getSingleProfileFromCache(id);

        return Right(localeUser!);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<ProfileEntity>>> searchProfiles(
    String query,
  ) async {
    try {
      final remoteUsers = await remoteDataSource.searchProfiles(query);

      return Right(remoteUsers);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
