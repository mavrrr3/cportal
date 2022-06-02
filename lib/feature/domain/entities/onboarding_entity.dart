class OnboardingEntity {
  final String title;
  final String description;
  final String image;
  final bool isVector;

  OnboardingEntity({
    required this.title,
    required this.description,
    required this.image,
    this.isVector = true,
  });
}
