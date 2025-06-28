import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../entities/restaurant.dart';
import '../repositories/restaurant_repository.dart';

/// Use case to filter restaurants by various criteria
class FilterRestaurantsUseCase {
  /// Repository instance
  final RestaurantRepository repository;

  /// Creates a new [FilterRestaurantsUseCase] instance
  FilterRestaurantsUseCase(this.repository);

  /// Execute the use case
  Future<Either<Failure, List<Restaurant>>> call(FilterParams params) async {
    // Get all restaurants first
    final restaurantsResult = await repository.getRestaurants();

    return restaurantsResult.fold(
      (failure) => Left(failure),
      (restaurants) {
        var filteredRestaurants = restaurants;

        // Filter by city if provided
        if (params.city != null) {
          filteredRestaurants = filteredRestaurants
              .where((restaurant) =>
                  restaurant.location.toLowerCase() ==
                  params.city!.toLowerCase())
              .toList();
        }

        // Filter by cuisine type if provided
        if (params.cuisineType != null) {
          filteredRestaurants = filteredRestaurants
              .where((restaurant) => restaurant.cuisineTypes.any((cuisine) =>
                  cuisine.toLowerCase() == params.cuisineType!.toLowerCase()))
              .toList();
        }

        // Filter by price range if provided
        if (params.minPrice != null && params.maxPrice != null) {
          filteredRestaurants = filteredRestaurants
              .where((restaurant) =>
                  restaurant.averagePrice >= params.minPrice! &&
                  restaurant.averagePrice <= params.maxPrice!)
              .toList();
        }

        // Filter by rating if provided
        if (params.minRating != null) {
          filteredRestaurants = filteredRestaurants
              .where((restaurant) => restaurant.rating >= params.minRating!)
              .toList();
        }

        // Filter by features if provided
        if (params.hasDelivery != null && params.hasDelivery!) {
          filteredRestaurants = filteredRestaurants
              .where((restaurant) => restaurant.hasDelivery)
              .toList();
        }

        if (params.hasTakeaway != null && params.hasTakeaway!) {
          filteredRestaurants = filteredRestaurants
              .where((restaurant) => restaurant.hasTakeaway)
              .toList();
        }

        if (params.hasReservations != null && params.hasReservations!) {
          filteredRestaurants = filteredRestaurants
              .where((restaurant) => restaurant.hasReservations)
              .toList();
        }

        // Sort by price if requested
        if (params.sortByPrice) {
          filteredRestaurants.sort((a, b) => params.sortAscending
              ? a.averagePrice.compareTo(b.averagePrice)
              : b.averagePrice.compareTo(a.averagePrice));
        }

        // Sort by rating if requested
        if (params.sortByRating) {
          filteredRestaurants.sort((a, b) => params.sortAscending
              ? a.rating.compareTo(b.rating)
              : b.rating.compareTo(a.rating));
        }

        return Right(filteredRestaurants);
      },
    );
  }
}

/// Parameters for the [FilterRestaurantsUseCase]
class FilterParams extends Equatable {
  /// City to filter by
  final String? city;

  /// Cuisine type to filter by
  final String? cuisineType;

  /// Minimum price to filter by
  final double? minPrice;

  /// Maximum price to filter by
  final double? maxPrice;

  /// Minimum rating to filter by
  final double? minRating;

  /// Whether to filter by delivery availability
  final bool? hasDelivery;

  /// Whether to filter by takeaway availability
  final bool? hasTakeaway;

  /// Whether to filter by reservation availability
  final bool? hasReservations;

  /// Whether to sort by price
  final bool sortByPrice;

  /// Whether to sort by rating
  final bool sortByRating;

  /// Whether to sort in ascending order
  final bool sortAscending;

  /// Creates a new [FilterParams] instance
  const FilterParams({
    this.city,
    this.cuisineType,
    this.minPrice,
    this.maxPrice,
    this.minRating,
    this.hasDelivery,
    this.hasTakeaway,
    this.hasReservations,
    this.sortByPrice = false,
    this.sortByRating = false,
    this.sortAscending = true,
  });

  @override
  List<Object?> get props => [
        city,
        cuisineType,
        minPrice,
        maxPrice,
        minRating,
        hasDelivery,
        hasTakeaway,
        hasReservations,
        sortByPrice,
        sortByRating,
        sortAscending,
      ];
}
