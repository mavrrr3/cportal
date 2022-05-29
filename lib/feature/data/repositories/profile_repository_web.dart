import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/feature/data/datasources/profile_datasource/profile_remote_datasource.dart';

import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_profile_repository.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryWeb implements IProfileRepository {
  final IProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryWeb({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, ProfileEntity>> getSingleProfile(String id) async {
    try {
      final remoteUser = await remoteDataSource.getSingleProfile(id);

      return Right(remoteUser);
    } on ServerException {
      return Left(ServerFailure());
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
