import 'package:equatable/equatable.dart';

/// Base failure class for all failures in the application
abstract class Failure extends Equatable {
  /// Error message
  final String message;

  /// Creates a new [Failure] instance
  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Server failure when there's an issue with the server
class ServerFailure extends Failure {
  /// Creates a new [ServerFailure] instance
  const ServerFailure({required String message}) : super(message: message);
}

/// Cache failure when there's an issue with local cache
class CacheFailure extends Failure {
  /// Creates a new [CacheFailure] instance
  const CacheFailure({required String message}) : super(message: message);
}

/// Network failure when there's an issue with internet connection
class NetworkFailure extends Failure {
  /// Creates a new [NetworkFailure] instance
  const NetworkFailure({required String message}) : super(message: message);
}

/// Authentication failure when there's an issue with authentication
class AuthFailure extends Failure {
  /// Creates a new [AuthFailure] instance
  const AuthFailure({required String message}) : super(message: message);
}
