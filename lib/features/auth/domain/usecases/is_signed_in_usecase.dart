import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

/// Use case for checking if a user is signed in
class IsSignedInUseCase {
  /// Repository for authentication
  final AuthRepository repository;

  /// Creates a new [IsSignedInUseCase] instance
  IsSignedInUseCase(this.repository);

  /// Executes the is signed in use case
  Future<Either<Failure, bool>> call() async {
    return await repository.isSignedIn();
  }
} 