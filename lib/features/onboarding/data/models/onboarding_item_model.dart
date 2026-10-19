class OnboardingItemModel {
  final String title;
  final String description;
  final String? imageAsset;

  const OnboardingItemModel({
    required this.title,
    required this.description,
    this.imageAsset,
  });
}
