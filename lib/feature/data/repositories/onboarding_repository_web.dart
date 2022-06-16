import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/feature/data/datasources/onboarding_datasource/onboarding_remote_datasource.dart';
import 'package:cportal_flutter/feature/domain/entities/onboarding_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_onboarding_repository.dart';
import 'package:dartz/dartz.dart';

class OnboardingRepositoryWeb implements IOnboardingRepository {
  final IOnboardingRemoteDataSource remoteDataSource;

  OnboardingRepositoryWeb({required this.remoteDataSource});

  @override
  Future<Either<Failure, OnboardingEntity>> fetchOnboarding() async {
    try {
      final remoteOnboarding = await remoteDataSource.fetchOnboarding();

      return Right(remoteOnboarding);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
