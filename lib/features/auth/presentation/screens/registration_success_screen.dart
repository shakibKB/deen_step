import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_assets.dart';
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const Spacer(flex: 2),

                // Registration Success Illustration Graphic
                Center(
                  child: SizedBox(
                    width: 190,
                    height: 190,
                    child: Image.asset(
                      AppAssets.registrationSuccess,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxxl),

                // Title
                Text(
                  'Registration Successful',
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),

                // Subtitle
                Text(
                  'Your account has been created successfully.\nWelcome to Deen.',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textMuted,
                    height: 1.45,
                  ),
                  textAlign: TextAlign.center,
                ),

                //const Spacer(flex: 3),
                SizedBox(height: 50),

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
                    ),
                    child: Text(
                      'Go to Home',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
