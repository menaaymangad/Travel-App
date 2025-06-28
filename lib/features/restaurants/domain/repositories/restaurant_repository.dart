import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/restaurant.dart';

/// Repository interface for restaurants
abstract class RestaurantRepository {
  /// Get all restaurants
  Future<Either<Failure, List<Restaurant>>> getRestaurants();

  /// Get a restaurant by its ID
  Future<Either<Failure, Restaurant>> getRestaurantById(String id);

  /// Get restaurants by city
  Future<Either<Failure, List<Restaurant>>> getRestaurantsByCity(String city);

  /// Get restaurants by cuisine type
  Future<Either<Failure, List<Restaurant>>> getRestaurantsByCuisine(
      String cuisineType);

  /// Get restaurants by price range
  Future<Either<Failure, List<Restaurant>>> getRestaurantsByPriceRange(
      double minPrice, double maxPrice);

  /// Search restaurants by query
  Future<Either<Failure, List<Restaurant>>> searchRestaurants(String query);
}
