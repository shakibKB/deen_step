import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/user_auth_model.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<AuthLoginSubmitted>(_onLoginSubmitted);
    on<AuthSignUpSubmitted>(_onSignUpSubmitted);
    on<AuthOtpVerifySubmitted>(_onOtpVerifySubmitted);
    on<AuthGuestLoginRequested>(_onGuestLoginRequested);
    on<AuthLoggedOut>(_onLoggedOut);
  }

  Future<void> _onLoginSubmitted(
    AuthLoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    // Phase 1 Mock simulation: allows immediate UI flow testing
    await Future<void>.delayed(const Duration(milliseconds: 600));

    if (event.email.isNotEmpty && event.password.isNotEmpty) {
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: UserAuthModel(
          id: 1,
          email: event.email,
          fullName: 'Demo User',
        ),
      ));
    } else {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Please enter valid email and password.',
      ));
    }
  }

  Future<void> _onSignUpSubmitted(
    AuthSignUpSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    await Future<void>.delayed(const Duration(milliseconds: 600));

    if (event.password != event.confirmPassword) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Passwords do not match.',
      ));
      return;
    }

    emit(state.copyWith(
      status: AuthStatus.unauthenticated,
      pendingOtpEmail: event.email,
    ));
  }

  Future<void> _onOtpVerifySubmitted(
    AuthOtpVerifySubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    await Future<void>.delayed(const Duration(milliseconds: 600));

    if (event.otp.length == 4) {
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: UserAuthModel(
          id: 1,
          email: event.email,
          fullName: 'Verified User',
        ),
      ));
    } else {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Invalid 4-digit code. Please try again.',
      ));
    }
  }

  Future<void> _onGuestLoginRequested(
    AuthGuestLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    await Future<void>.delayed(const Duration(milliseconds: 400));
    emit(state.copyWith(
      status: AuthStatus.authenticated,
      user: const UserAuthModel(
        id: 99,
        email: 'guest@deenstep.app',
        fullName: 'Guest User',
        isGuest: true,
      ),
    ));
  }

  void _onLoggedOut(AuthLoggedOut event, Emitter<AuthState> emit) {
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }
}
