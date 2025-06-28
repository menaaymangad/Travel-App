import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// Utility class for input validation and conversion
class InputConverter {
  /// Validates and converts a string to an integer
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw const FormatException();
      return Right(integer);
    } on FormatException {
      return Left(AuthFailure(message: 'Invalid input'));
    }
  }

  /// Validates email format
  Either<Failure, String> validateEmail(String email) {
    final emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (emailRegExp.hasMatch(email)) {
      return Right(email);
    } else {
      return Left(AuthFailure(message: 'Invalid email format'));
    }
  }

  /// Validates password strength
  Either<Failure, String> validatePassword(String password) {
    if (password.length >= 6) {
      return Right(password);
    } else {
      return Left(
          AuthFailure(message: 'Password must be at least 6 characters'));
    }
  }
} 