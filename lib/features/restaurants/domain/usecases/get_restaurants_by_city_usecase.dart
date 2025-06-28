import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../entities/restaurant.dart';
import '../repositories/restaurant_repository.dart';

/// Use case to get restaurants by city
class GetRestaurantsByCityUseCase {
  /// Repository instance
  final RestaurantRepository repository;

  /// Creates a new [GetRestaurantsByCityUseCase] instance
  GetRestaurantsByCityUseCase(this.repository);

  /// Execute the use case
  Future<Either<Failure, List<Restaurant>>> call(CityParams params) {
    return repository.getRestaurantsByCity(params.city);
  }
}

/// Parameters for the [GetRestaurantsByCityUseCase]
class CityParams extends Equatable {
  /// City name
  final String city;

  /// Creates a new [CityParams] instance
  const CityParams({required this.city});

  @override
  List<Object?> get props => [city];
}
