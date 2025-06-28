import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

/// Base state for authentication
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Initial state
class AuthInitial extends AuthState {}

/// Loading state
class AuthLoading extends AuthState {}

/// Authenticated state
class AuthAuthenticated extends AuthState {
  /// The authenticated user
  final User user;

  /// Creates a new [AuthAuthenticated] state
  AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// Unauthenticated state
class AuthUnauthenticated extends AuthState {}

/// Error state
class AuthError extends AuthState {
  /// The error message
  final String message;

  /// Creates a new [AuthError] state
  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Password visibility changed state
class AuthPasswordVisibilityChanged extends AuthState {
  /// Whether the password is visible
  final bool isVisible;

  /// Creates a new [AuthPasswordVisibilityChanged] state
  AuthPasswordVisibilityChanged(this.isVisible);

  @override
  List<Object?> get props => [isVisible];
}

/// Password reset sent state
class AuthPasswordResetSent extends AuthState {} 