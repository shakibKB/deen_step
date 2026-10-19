import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLoginSubmitted extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginSubmitted({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthSignUpSubmitted extends AuthEvent {
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;

  const AuthSignUpSubmitted({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [fullName, email, password, confirmPassword];
}

class AuthOtpVerifySubmitted extends AuthEvent {
  final String email;
  final String otp;

  const AuthOtpVerifySubmitted({required this.email, required this.otp});

  @override
  List<Object?> get props => [email, otp];
}

class AuthGuestLoginRequested extends AuthEvent {
  const AuthGuestLoginRequested();
}

class AuthLoggedOut extends AuthEvent {
  const AuthLoggedOut();
}
