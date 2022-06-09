import 'package:cportal_flutter/core/error/cache_exception.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/platform/i_network_info.dart';
import 'package:cportal_flutter/feature/data/datasources/profile_datasource/profile_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/profile_datasource/profile_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/profile_model.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_profile_repository.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryMobile implements IProfileRepository {
  final IProfileRemoteDataSource remoteDataSource;
  final IProfileLocalDataSource localDataSource;
  final INetworkInfo networkInfo;

  ProfileRepositoryMobile({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProfileModel>> getSingleProfile(
    String id,
    bool isMyProfile,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser =
            await remoteDataSource.getSingleProfile(id, isMyProfile);

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
  Future<Either<Failure, List<ProfileModel>>> searchProfiles(
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
