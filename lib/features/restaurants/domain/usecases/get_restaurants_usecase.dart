import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../entities/restaurant.dart';
import '../repositories/restaurant_repository.dart';

/// Use case to get all restaurants
class GetRestaurantsUseCase {
  /// Repository instance
  final RestaurantRepository repository;

  /// Creates a new [GetRestaurantsUseCase] instance
  GetRestaurantsUseCase(this.repository);

  /// Execute the use case
  Future<Either<Failure, List<Restaurant>>> call(NoParams params) {
    return repository.getRestaurants();
  }
}

/// No parameters needed for this use case
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
