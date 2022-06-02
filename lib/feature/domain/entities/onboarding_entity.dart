import 'package:equatable/equatable.dart';

class OnboardingEntity extends Equatable {
  final String title;
  final String description;
  final String image;
  final bool isVector;

  const OnboardingEntity({
    required this.title,
    required this.description,
    required this.image,
    this.isVector = true,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        title,
        description,
        image,
        isVector,
      ];
}
