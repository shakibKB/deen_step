import 'package:deen_step/features/auth/presentation/screens/login_screen.dart';
import 'package:deen_step/features/auth/presentation/screens/otp_verification_screen.dart';
import 'package:deen_step/features/auth/presentation/screens/registration_success_screen.dart';
import 'package:deen_step/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:deen_step/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Widget createTestWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<AuthBloc>(
        create: (_) => AuthBloc(),
        child: child,
      ),
    );
  }

  group('Authentication Flow Widget Tests', () {
    testWidgets('LoginScreen renders header, inputs, and disabled CTA initially',
        (tester) async {
      await tester.pumpWidget(createTestWidget(const LoginScreen()));

      expect(find.text('Welcome Back'), findsOneWidget);
      expect(find.text('Email Address'), findsWidgets);
      expect(find.text('Password'), findsWidgets);
      expect(find.text('Forgot password?'), findsOneWidget);
      expect(find.text('Log In'), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
    });

    testWidgets('SignUpScreen renders title, inputs, and terms agreement',
        (tester) async {
      await tester.pumpWidget(createTestWidget(const SignUpScreen()));

      expect(find.text('Create Account'), findsOneWidget);
      expect(find.text('Full Name'), findsWidgets);
      expect(find.text('Email Address'), findsWidgets);
      expect(find.text('Password'), findsWidgets);
      expect(find.text('Confirm Password'), findsWidgets);
      expect(find.text('Register Account'), findsOneWidget);
    });

    testWidgets('OtpVerificationScreen renders 4 boxes and resend timer',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          const OtpVerificationScreen(email: 'abid45@example.com'),
        ),
      );

      expect(find.text('Verify Email'), findsOneWidget);
      expect(find.textContaining('abid45@example.com'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(4));
      expect(find.text('Verify'), findsOneWidget);
    });

    testWidgets('RegistrationSuccessScreen renders confirmation and Go to Home',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(const RegistrationSuccessScreen()),
      );

      expect(find.text('Registration Successful'), findsOneWidget);
      expect(find.textContaining('Welcome to Deen'), findsOneWidget);
      expect(find.text('Go to Home'), findsOneWidget);
    });
  });
}
