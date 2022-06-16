import 'package:equatable/equatable.dart';

class OnboardingEntity extends Equatable {
  final int onboardingDuration;
  final int learningCourseDuration;
  final List<OnboardingItemEntity> pages;
  final OnboardingItemEntity course;

  const OnboardingEntity({
    required this.onboardingDuration,
    required this.learningCourseDuration,
    required this.pages,
    required this.course,
  });

  @override
  List<Object?> get props => [
        onboardingDuration,
        learningCourseDuration,
        pages,
        course,
      ];
}

class OnboardingItemEntity extends Equatable {
  final String header;
  final String description;
  final String image;
  final bool isVector;

  const OnboardingItemEntity({
    required this.header,
    required this.description,
    required this.image,
    this.isVector = true,
  });

  @override
  List<Object?> get props => [
        header,
        description,
        image,
        isVector,
      ];
}
