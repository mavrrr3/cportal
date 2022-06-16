import 'package:cportal_flutter/feature/domain/entities/onboarding_entity.dart';
import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

class OnboardingEmptyState extends OnboardingState {}

class OnboardingLoadingState extends OnboardingState {}

class OnboardingLoadedState extends OnboardingState {
  final OnboardingEntity onboarding;

  const OnboardingLoadedState({required this.onboarding});

  @override
  List<Object?> get props => [onboarding];
}

class OnboardingLoadingErrorState extends OnboardingState {
  final String message;
  const OnboardingLoadingErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
