import 'package:equatable/equatable.dart';
import '../../data/models/user_auth_model.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final UserAuthModel? user;
  final String? errorMessage;
  final String? pendingOtpEmail;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
    this.pendingOtpEmail,
  });

  AuthState copyWith({
    AuthStatus? status,
    UserAuthModel? user,
    String? errorMessage,
    String? pendingOtpEmail,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage,
      pendingOtpEmail: pendingOtpEmail ?? this.pendingOtpEmail,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMessage, pendingOtpEmail];
}
