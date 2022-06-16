import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/onboarding_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_onboarding_repository.dart';
import 'package:dartz/dartz.dart';

class FetchOnboardingUseCase {
  final IOnboardingRepository onboardingRepository;

  FetchOnboardingUseCase(this.onboardingRepository);

  Future<Either<Failure, OnboardingEntity>> call() async =>
      onboardingRepository.fetchOnboarding();
}
