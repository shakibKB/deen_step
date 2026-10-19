import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_routes.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../widgets/deen_step_logo.dart';
import '../widgets/mosque_silhouette_painter.dart';
import '../widgets/star_field_painter.dart';

/// Progressive Splash Screen accurately matching the 4-frame Figma sequence.
/// Animates the logo, rising mosque silhouette, and bottom action buttons.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoFadeAnimation;
  late final Animation<Offset> _mosqueSlideAnimation;
  late final Animation<double> _buttonsFadeAnimation;
  late final Animation<Offset> _buttonsSlideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // Frame 1: Logo & text fade in
    _logoFadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
    );

    // Frames 2 & 3: Mosque silhouette rises from the bottom
    _mosqueSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.45),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.80, curve: Curves.easeOutCubic),
      ),
    );

    // Frame 4: Buttons fade & slide up into place
    _buttonsFadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.60, 1.0, curve: Curves.easeIn),
    );

    _buttonsSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.60, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onCreateAccount() {
    context.push(AppRoutes.signUp);
  }

  void _onLogIn() {
    context.push(AppRoutes.login);
  }

  void _onContinueAsGuest() {
    context.read<AuthBloc>().add(const AuthGuestLoginRequested());
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: Stack(
        children: [
          // 1. Subtle Celestial Star Specks in Night Sky
          const Positioned.fill(
            child: CustomPaint(
              painter: StarFieldPainter(),
            ),
          ),

          // 2. Rising Mosque Silhouette at Bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: size.height * 0.42,
            child: SlideTransition(
              position: _mosqueSlideAnimation,
              child: CustomPaint(
                size: Size(size.width, size.height * 0.42),
                painter: MosqueSilhouettePainter(),
              ),
            ),
          ),

          // 3. Central Brand Identity (Logo + Name + Tagline)
          SafeArea(
            child: Align(
              alignment: const Alignment(0.0, -0.22),
              child: FadeTransition(
                opacity: _logoFadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Crescent Moon in Neon Lime
                      const DeenStepLogo(size: 60),
                      const SizedBox(height: AppSpacing.lg),

                      // DEEN-STEP Title
                      const Text(
                        AppStrings.appNameUpper,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),

                      // Tagline text matching Figma exact copy
                      const Text(
                        AppStrings.splashTagline,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textMuted,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 4. Bottom Action Buttons (Frame 4 in Figma)
          Positioned(
            left: AppSpacing.xxl,
            right: AppSpacing.xxl,
            bottom: AppSpacing.xxl,
            child: SlideTransition(
              position: _buttonsSlideAnimation,
              child: FadeTransition(
                opacity: _buttonsFadeAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Primary CTA: "Create Account"
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _onCreateAccount,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.brandLime,
                          foregroundColor: const Color(0xFF111814),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.1,
                          ),
                        ),
                        child: const Text(AppStrings.createAccount),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Secondary CTA: "Already registered? Log In"
                    SizedBox(
                      height: 52,
                      child: OutlinedButton(
                        onPressed: _onLogIn,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.darkButtonBg,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          side: const BorderSide(
                            color: AppColors.darkButtonBorder,
                            width: 1.2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: const Text(AppStrings.alreadyRegisteredLogIn),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Tertiary Link: "Continue as Guest"
                    Center(
                      child: TextButton(
                        onPressed: _onContinueAsGuest,
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.textMuted,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                            vertical: AppSpacing.xs,
                          ),
                        ),
                        child: const Text(
                          AppStrings.continueAsGuest,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
