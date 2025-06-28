import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Use case for registering a new user
class RegisterUseCase {
  /// Repository for authentication
  final AuthRepository repository;

  /// Creates a new [RegisterUseCase] instance
  RegisterUseCase(this.repository);

  /// Executes the register use case
  Future<Either<Failure, User>> call(RegisterParams params) async {
    return await repository.register(
      name: params.name,
      email: params.email,
      password: params.password,
      phone: params.phone,
    );
  }
}

/// Parameters for the register use case
class RegisterParams extends Equatable {
  /// User name
  final String name;
  
  /// Email address
  final String email;
  
  /// Password
  final String password;
  
  /// Phone number
  final String phone;

  /// Creates a new [RegisterParams] instance
  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  @override
  List<Object?> get props => [name, email, password, phone];
} 