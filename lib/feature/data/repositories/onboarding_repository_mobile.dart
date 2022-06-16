import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/platform/i_network_info.dart';
import 'package:cportal_flutter/feature/data/datasources/onboarding_datasource/onboarding_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/onboarding_datasource/onboarding_remote_datasource.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/onboarding_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_onboarding_repository.dart';
import 'package:dartz/dartz.dart';

class OnboardingRepositoryMobile implements IOnboardingRepository {
  final IOnboardingRemoteDataSource remoteDataSource;
  final IOnboardingLocalDataSource localDataSource;
  final INetworkInfo networkInfo;

  OnboardingRepositoryMobile({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, OnboardingEntity>> fetchOnboarding() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteOnboarding = await remoteDataSource.fetchOnboarding();

        return Right(remoteOnboarding);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localOnboarding =
            await localDataSource.fetchOnboardingFromCache();

        return Right(localOnboarding);
      } on CacheFailure {
        return Left(CacheFailure());
      }
    }
  }
}
