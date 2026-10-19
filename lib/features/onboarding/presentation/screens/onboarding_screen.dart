import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/app_button.dart';
import '../../data/models/onboarding_item_model.dart';

/// Onboarding Screen foundation with carousel slides.
/// Ready to receive exact Figma layout and assets.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItemModel> _items = const [
    OnboardingItemModel(
      title: 'Track Your Daily Prayers',
      description: 'Accurate prayer timings, customizable alerts, and streak tracking wherever you are.',
    ),
    OnboardingItemModel(
      title: 'Reflect and Grow in Faith',
      description: 'Log your gratitude, track daily moods, and gain curated Qur’anic insights.',
    ),
    OnboardingItemModel(
      title: 'Connect with Community',
      description: 'Join faithful communities, share inspiring reflections, and grow together.',
    ),
  ];

  void _onNext() {
    if (_currentPage < _items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go(AppRoutes.login);
    }
  }

  void _onSkip() {
    context.go(AppRoutes.login);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLastPage = _currentPage == _items.length - 1;

    return Scaffold(
      appBar: AppBar(
        actions: [
          if (!isLastPage)
            TextButton(
              onPressed: _onSkip,
              child: const Text(AppStrings.skip),
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.paddingPage,
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.menu_book_rounded,
                          size: 100,
                          color: AppColors.primary,
                        ),
                        const SizedBox(height: AppSpacing.xxxl),
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _items.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: _currentPage == index ? 24 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? AppColors.primary : AppColors.borderLight,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              AppButton(
                text: isLastPage ? AppStrings.getStarted : AppStrings.next,
                onPressed: _onNext,
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}
