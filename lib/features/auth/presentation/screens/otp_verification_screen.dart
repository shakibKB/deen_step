import 'dart:async';
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

/// Pixel-perfect OTP Verification Screen matching Figma.
class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({
    super.key,
    required this.email,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  int _resendCountdown = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    setState(() {
      _resendCountdown = 30;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() {
          _resendCountdown--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _otpCode => _controllers.map((c) => c.text).join();
  bool get _isComplete => _otpCode.length == 4;

  void _onVerify() {
    if (!_isComplete) return;
    context.read<AuthBloc>().add(
          AuthOtpVerifySubmitted(
            email: widget.email,
            otp: _otpCode,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          context.go(AppRoutes.registrationSuccess);
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
        final isEnabled = _isComplete && !isLoading;

        return Scaffold(
          backgroundColor: AppColors.authBackground,
          body: SafeArea(
            child: Padding(
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
                    'Verify Email',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Subtitle with highlighted email
                  Text.rich(
                    TextSpan(
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textMuted,
                        height: 1.45,
                      ),
                      children: [
                        const TextSpan(
                          text: "We've sent a 4-digit verification code to \n",
                        ),
                        TextSpan(
                          text: widget.email,
                          style: const TextStyle(
                            color: AppColors.brandLime,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxxl),

                  // 4 OTP Boxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) {
                      final hasFocus = _focusNodes[index].hasFocus;
                      final hasValue = _controllers[index].text.isNotEmpty;

                      return Container(
                        width: 66,
                        height: 66,
                        decoration: BoxDecoration(
                          color: AppColors.inputBackground,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: hasFocus
                                ? AppColors.brandLime
                                : (hasValue
                                    ? const Color(0xFF38433C)
                                    : AppColors.inputBorder),
                            width: hasFocus ? 1.5 : 1.2,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          cursorColor: AppColors.brandLime,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            counterText: '',
                            contentPadding: EdgeInsets.zero,
                          ),
                          onChanged: (value) {
                            setState(() {});
                            if (value.isNotEmpty && index < 3) {
                              _focusNodes[index + 1].requestFocus();
                            } else if (value.isEmpty && index > 0) {
                              _focusNodes[index - 1].requestFocus();
                            }
                          },
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: AppSpacing.xxxl),

                  // Verify Action Button
                  SizedBox(
                    height: 52,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isEnabled ? _onVerify : null,
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
                          fontSize: 16,
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
                          : const Text('Verify'),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Resend Code Countdown / Action
                  Center(
                    child: _resendCountdown > 0
                        ? RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF8E9B93),
                              ),
                              children: [
                                const TextSpan(text: "Didn't receive code? "),
                                TextSpan(
                                  text:
                                      'Resend in 00:${_resendCountdown.toString().padLeft(2, '0')}',
                                  style: const TextStyle(
                                    color: AppColors.brandLime,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Didn't receive code? ",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF8E9B93),
                                ),
                              ),
                              GestureDetector(
                                onTap: _startCountdown,
                                child: const Text(
                                  'Resend Code',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.brandLime,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
