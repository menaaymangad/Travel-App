import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

/// Repository interface for authentication
abstract class AuthRepository {
  /// Signs in a user with email and password
  Future<Either<Failure, User>> signIn({
    required String email,
    required String password,
  });

  /// Registers a new user with email and password
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  });

  /// Signs out the current user
  Future<Either<Failure, void>> signOut();

  /// Resets the user's password
  Future<Either<Failure, void>> resetPassword({
    required String email,
  });

  /// Gets the current user data
  Future<Either<Failure, User>> getCurrentUser();

  /// Checks if a user is signed in
  Future<Either<Failure, bool>> isSignedIn();
} 