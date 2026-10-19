import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/router/app_routes.dart';

/// Registration Successful Screen matching Figma design.
class RegistrationSuccessScreen extends StatelessWidget {
  const RegistrationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Concentric Radar Rings & Checkmark Graphic
              Center(
                child: SizedBox(
                  width: 170,
                  height: 170,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer faint ring
                      Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF1E2E22),
                            width: 1.2,
                          ),
                        ),
                      ),
                      // Middle ring
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF283F2E),
                            width: 1.2,
                          ),
                        ),
                      ),
                      // Orbiting decorative dots
                      Positioned(
                        top: 18,
                        left: 45,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: AppColors.brandLime,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        right: 25,
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: AppColors.brandLime.withValues(alpha: 0.7),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // Central Neon Lime Circle with Checkmark
                      Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          color: AppColors.brandLime,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.brandLime.withValues(alpha: 0.35),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.check_rounded,
                            size: 38,
                            color: Color(0xFF111814),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Title
              const Text(
                'Registration Successful',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),

              // Subtitle
              const Text(
                'Your account has been created successfully.\nWelcome to Deen.',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textMuted,
                  height: 1.45,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(flex: 3),

              // "Go to Home" Action Button
              SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.go(AppRoutes.home);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brandLime,
                    foregroundColor: const Color(0xFF111814),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.1,
                    ),
                  ),
                  child: const Text('Go to Home'),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}
