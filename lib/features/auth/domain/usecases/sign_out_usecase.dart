import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

/// Use case for signing out a user
class SignOutUseCase {
  /// Repository for authentication
  final AuthRepository repository;

  /// Creates a new [SignOutUseCase] instance
  SignOutUseCase(this.repository);

  /// Executes the sign out use case
  Future<Either<Failure, void>> call() async {
    return await repository.signOut();
  }
} 