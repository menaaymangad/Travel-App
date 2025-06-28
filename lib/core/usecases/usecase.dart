import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../error/failures.dart';

/// Base class for all use cases
abstract class UseCase<Type, Params> {
  /// Execute the use case with the given parameters
  Future<Either<Failure, Type>> call(Params params);
}

/// Parameters for use cases that don't require parameters
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
