import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Use case for getting the current user
class GetCurrentUserUseCase {
  /// Repository for authentication
  final AuthRepository repository;

  /// Creates a new [GetCurrentUserUseCase] instance
  GetCurrentUserUseCase(this.repository);

  /// Executes the get current user use case
  Future<Either<Failure, User>> call() async {
    return await repository.getCurrentUser();
  }
} 