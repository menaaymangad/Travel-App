import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/input_converter.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/is_signed_in_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import 'auth_state.dart';

/// Cubit for handling authentication
class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase _signInUseCase;
  final RegisterUseCase _registerUseCase;
  final SignOutUseCase _signOutUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final IsSignedInUseCase _isSignedInUseCase;
  final InputConverter _inputConverter;

  /// Creates a new [AuthCubit] instance
  AuthCubit({
    required SignInUseCase signInUseCase,
    required RegisterUseCase registerUseCase,
    required SignOutUseCase signOutUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required IsSignedInUseCase isSignedInUseCase,
    required InputConverter inputConverter,
  })  : _signInUseCase = signInUseCase,
        _registerUseCase = registerUseCase,
        _signOutUseCase = signOutUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase,
        _isSignedInUseCase = isSignedInUseCase,
        _inputConverter = inputConverter,
        super(AuthInitial());

  /// Password visibility icon
  Icon suffix = const Icon(Icons.visibility_outlined);

  /// Whether the password is visible
  bool isPasswordVisible = false;

  /// Changes the password visibility
  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    suffix = isPasswordVisible
        ? const Icon(Icons.visibility_off_outlined)
        : const Icon(Icons.visibility_outlined);
    emit(AuthPasswordVisibilityChanged(isPasswordVisible));
  }

  /// Signs in a user with email and password
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    // Validate email
    final emailValidation = _inputConverter.validateEmail(email);
    if (emailValidation.isLeft()) {
      emit(AuthError('Invalid email format'));
      return;
    }

    // Validate password
    final passwordValidation = _inputConverter.validatePassword(password);
    if (passwordValidation.isLeft()) {
      emit(AuthError('Password must be at least 6 characters'));
      return;
    }

    final result = await _signInUseCase(
      SignInParams(
        email: email,
        password: password,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.toString())),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  /// Registers a new user
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(AuthLoading());

    // Validate email
    final emailValidation = _inputConverter.validateEmail(email);
    if (emailValidation.isLeft()) {
      emit(AuthError('Invalid email format'));
      return;
    }

    // Validate password
    final passwordValidation = _inputConverter.validatePassword(password);
    if (passwordValidation.isLeft()) {
      emit(AuthError('Password must be at least 6 characters'));
      return;
    }

    final result = await _registerUseCase(
      RegisterParams(
        name: name,
        email: email,
        password: password,
        phone: phone,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.toString())),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  /// Signs out the current user
  Future<void> signOut() async {
    emit(AuthLoading());

    final result = await _signOutUseCase();

    result.fold(
      (failure) => emit(AuthError(failure.toString())),
      (_) => emit(AuthUnauthenticated()),
    );
  }

  /// Resets the user's password
  Future<void> resetPassword({required String email}) async {
    emit(AuthLoading());

    // Validate email
    final emailValidation = _inputConverter.validateEmail(email);
    if (emailValidation.isLeft()) {
      emit(AuthError('Invalid email format'));
      return;
    }

    final result = await _resetPasswordUseCase(
      ResetPasswordParams(email: email),
    );

    result.fold(
      (failure) => emit(AuthError(failure.toString())),
      (_) => emit(AuthPasswordResetSent()),
    );
  }

  /// Gets the current user
  Future<void> getCurrentUser() async {
    emit(AuthLoading());

    final result = await _getCurrentUserUseCase();

    result.fold(
      (failure) => emit(AuthError(failure.toString())),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  /// Checks if a user is signed in
  Future<void> checkAuthStatus() async {
    emit(AuthLoading());

    final result = await _isSignedInUseCase();

    result.fold(
      (failure) => emit(AuthUnauthenticated()),
      (isSignedIn) async {
        if (isSignedIn) {
          await getCurrentUser();
        } else {
          emit(AuthUnauthenticated());
        }
      },
    );
  }
}
