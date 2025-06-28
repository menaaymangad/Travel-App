import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

/// Use case for resetting a user's password
class ResetPasswordUseCase {
  /// Repository for authentication
  final AuthRepository repository;

  /// Creates a new [ResetPasswordUseCase] instance
  ResetPasswordUseCase(this.repository);

  /// Executes the reset password use case
  Future<Either<Failure, void>> call(ResetPasswordParams params) async {
    return await repository.resetPassword(
      email: params.email,
    );
  }
}

/// Parameters for the reset password use case
class ResetPasswordParams extends Equatable {
  /// Email address
  final String email;

  /// Creates a new [ResetPasswordParams] instance
  const ResetPasswordParams({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
} 