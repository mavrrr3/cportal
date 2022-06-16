import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/onboarding_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IOnboardingRepository {
  Future<Either<Failure, OnboardingEntity>> fetchOnboarding();
}
