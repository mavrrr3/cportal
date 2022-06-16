import 'package:cportal_flutter/feature/domain/entities/onboarding_entity.dart';
import 'package:hive/hive.dart';

part 'onboarding_model.g.dart';

// ignore_for_file: annotate_overrides, overridden_fields
@HiveType(typeId: 11)
class OnboardingModel extends OnboardingEntity {
  @HiveField(0)
  final int onboardingDuration;

  @HiveField(1)
  final int learningCourseDuration;

  @HiveField(2)
  final List<OnboardingItemModel> pages;

  @HiveField(3)
  final OnboardingItemModel course;

  const OnboardingModel({
    required this.onboardingDuration,
    required this.learningCourseDuration,
    required this.pages,
    required this.course,
  }) : super(
          onboardingDuration: onboardingDuration,
          learningCourseDuration: learningCourseDuration,
          pages: pages,
          course: course,
        );

  factory OnboardingModel.fromJson(Map<String, dynamic> json) =>
      OnboardingModel(
        onboardingDuration: json['onboarding_duration'] as int,
        learningCourseDuration: json['learning_course_duration'] as int,
        pages: List<OnboardingItemModel>.from(
          json['onboarding_pages'].map((dynamic x) =>
                  OnboardingItemModel.fromJson(x as Map<String, dynamic>))
              as Iterable<dynamic>,
        ),
        course: OnboardingItemModel.fromJson(
          json['learning_course'] as Map<String, dynamic>,
        ),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'onboarding_duration': onboardingDuration,
        'learning_course_duration': learningCourseDuration,
        'onboarding_pages':
            List<dynamic>.from(pages.map<dynamic>((x) => x.toJson())),
        'learning_course': course.toJson(),
      };
}

@HiveType(typeId: 12)
class OnboardingItemModel extends OnboardingItemEntity {
  @override
  @HiveField(0)
  final String header;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final bool isVector;

  const OnboardingItemModel({
    required this.header,
    required this.description,
    required this.image,
    this.isVector = true,
  }) : super(
          header: header,
          description: description,
          image: image,
        );

  factory OnboardingItemModel.fromJson(Map<String, dynamic> json) =>
      OnboardingItemModel(
        header: json['header'] as String,
        description: json['description'] as String,
        image: json['img'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'header': header,
        'description': description,
        'img': image,
      };
}
