import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Use case for signing in a user
class SignInUseCase {
  /// Repository for authentication
  final AuthRepository repository;

  /// Creates a new [SignInUseCase] instance
  SignInUseCase(this.repository);

  /// Executes the sign in use case
  Future<Either<Failure, User>> call(SignInParams params) async {
    return await repository.signIn(
      email: params.email,
      password: params.password,
    );
  }
}

/// Parameters for the sign in use case
class SignInParams extends Equatable {
  /// Email address
  final String email;
  
  /// Password
  final String password;

  /// Creates a new [SignInParams] instance
  const SignInParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
} 