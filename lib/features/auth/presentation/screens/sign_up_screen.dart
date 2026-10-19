import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/router/app_routes.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/auth_back_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/social_login_section.dart';

/// Pixel-perfect Create Account / Registration Screen matching Figma.
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreedToTerms = false;

  bool get _isFormValid =>
      _fullNameController.text.trim().isNotEmpty &&
      _emailController.text.trim().isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty &&
      _agreedToTerms;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (!_isFormValid) return;
    context.read<AuthBloc>().add(
          AuthSignUpSubmitted(
            fullName: _fullNameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
            confirmPassword: _confirmPasswordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.pendingOtpEmail != null) {
          context.push(AppRoutes.otp, extra: state.pendingOtpEmail);
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

                  // Title
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Subtitle
                  const Text(
                    'Start your consistent steps towards spiritual growth.',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textMuted,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // Full Name Field
                  AuthTextField(
                    controller: _fullNameController,
                    label: 'Full Name',
                    hintText: 'Full Name',
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Email Field
                  AuthTextField(
                    controller: _emailController,
                    label: 'Email Address',
                    hintText: 'Email Address',
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Password Field
                  AuthTextField(
                    controller: _passwordController,
                    label: 'Password',
                    hintText: 'Password',
                    isPassword: true,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Confirm Password Field
                  AuthTextField(
                    controller: _confirmPasswordController,
                    label: 'Confirm Password',
                    hintText: 'Confirm Password',
                    isPassword: true,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Terms & Privacy Agreement Checkbox Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _agreedToTerms = !_agreedToTerms;
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          margin: const EdgeInsets.only(top: 2),
                          decoration: BoxDecoration(
                            color: _agreedToTerms
                                ? AppColors.brandLime
                                : const Color(0xFF1B201C),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: _agreedToTerms
                                  ? AppColors.brandLime
                                  : const Color(0xFF38433C),
                              width: 1.5,
                            ),
                          ),
                          child: _agreedToTerms
                              ? const Icon(
                                  Icons.check,
                                  size: 14,
                                  color: Color(0xFF111814),
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 12.5,
                              color: Color(0xFF8E9B93),
                              height: 1.45,
                            ),
                            children: [
                              TextSpan(text: 'I agree to the '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: AppColors.brandLime,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Terms.',
                                style: TextStyle(
                                  color: AppColors.brandLime,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: '\nClick here to Read.',
                                style: TextStyle(
                                  color: AppColors.brandLime,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // Register Account Action Button
                  SizedBox(
                    height: 52,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isEnabled ? _onRegister : null,
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
                          : const Text('Register Account'),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // "Have an account? Log In"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Have an account? ',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF8E9B93),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: const Text(
                          'Log In',
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

                  // Social Registration Section
                  SocialLoginSection(
                    onGoogleTap: () {
                      context.read<AuthBloc>().add(const AuthGuestLoginRequested());
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
