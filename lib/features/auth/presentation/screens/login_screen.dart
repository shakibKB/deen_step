import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/router/app_routes.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/auth_back_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/social_login_section.dart';

/// Pixel-perfect Login Screen matching Figma.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool get _isFormValid =>
      _emailController.text.trim().isNotEmpty &&
      _passwordController.text.isNotEmpty;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogIn() {
    if (!_isFormValid) return;
    context.read<AuthBloc>().add(
      AuthLoginSubmitted(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          context.go(AppRoutes.home);
        } else if (state.status == AuthStatus.error &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == AuthStatus.loading;
        final isEnabled = _isFormValid && !isLoading;

        return Scaffold(
          backgroundColor: AppColors.authBackground,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.md),

                  // Back Button
                  const AuthBackButton(),
                  const SizedBox(height: AppSpacing.xxl),

                  // Header Title
                  Text(
                    'Welcome Back',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Subtitle
                  SizedBox(
                    width: 320,
                    child: Text(
                      'Enter your details to access your Deen-step habits.',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textMuted,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxxl),

                  // Email Field
                  AuthTextField(
                    controller: _emailController,
                    label: 'Email Address',
                    hintText: 'Email Address',
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Password Field
                  AuthTextField(
                    controller: _passwordController,
                    label: 'Password',
                    hintText: 'Password',
                    isPassword: true,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Forgot Password Link
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // Reserved for password recovery
                      },
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.brandLime,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // Log In Action Button (Dynamic enabled/disabled state matching Figma)
                  SizedBox(
                    height: 52,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isEnabled ? _onLogIn : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isEnabled
                            ? AppColors.brandLime
                            : AppColors.buttonDisabledBg,
                        foregroundColor: isEnabled
                            ? const Color(0xFF111814)
                            : AppColors.buttonDisabledText,
                        disabledBackgroundColor: AppColors.buttonDisabledBg,
                        disabledForegroundColor: AppColors.buttonDisabledText,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xFF111814),
                              ),
                            )
                          : Text(
                              'Log In',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF111827),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // "Dont have an account? Sign Up"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Dont have an account? ',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF8E9B93),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.push(AppRoutes.signUp);
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.brandLime,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxxl),

                  // Social Log In Section (Google & Apple)
                  SocialLoginSection(
                    onGoogleTap: () {
                      context.read<AuthBloc>().add(
                        const AuthGuestLoginRequested(),
                      );
                      context.go(AppRoutes.home);
                    },
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
