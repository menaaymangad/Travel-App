import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/usecases/filter_restaurants_usecase.dart';
import '../../domain/usecases/get_restaurants_by_city_usecase.dart';
import '../../domain/usecases/get_restaurants_usecase.dart';
import 'restaurants_state.dart';

/// Cubit for managing restaurants state
class RestaurantsCubit extends Cubit<RestaurantsState> {
  /// Get restaurants use case
  final GetRestaurantsUseCase getRestaurantsUseCase;

  /// Get restaurants by city use case
  final GetRestaurantsByCityUseCase getRestaurantsByCityUseCase;

  /// Filter restaurants use case
  final FilterRestaurantsUseCase filterRestaurantsUseCase;

  /// Creates a new [RestaurantsCubit] instance
  RestaurantsCubit({
    required this.getRestaurantsUseCase,
    required this.getRestaurantsByCityUseCase,
    required this.filterRestaurantsUseCase,
  }) : super(RestaurantsInitial());

  /// Get all restaurants
  Future<void> getRestaurants() async {
    emit(RestaurantsLoading());
    final result = await getRestaurantsUseCase(NoParams());
    result.fold(
      (failure) => emit(RestaurantsError(message: failure.message)),
      (restaurants) => emit(RestaurantsLoaded(restaurants: restaurants)),
    );
  }

  /// Get restaurants by city
  Future<void> getRestaurantsByCity(String city) async {
    emit(RestaurantsLoading());
    final result = await getRestaurantsByCityUseCase(CityParams(city: city));
    result.fold(
      (failure) => emit(RestaurantsError(message: failure.message)),
      (restaurants) => emit(RestaurantsLoaded(restaurants: restaurants)),
    );
  }

  /// Get restaurant details by ID
  Future<void> getRestaurantDetails(String id) async {
    emit(RestaurantsLoading());
    // Implementation would require a specific use case
    // For now, we'll filter the restaurants after fetching all
    final result = await getRestaurantsUseCase(NoParams());
    result.fold(
      (failure) => emit(RestaurantsError(message: failure.message)),
      (restaurants) {
        try {
          final restaurant = restaurants.firstWhere(
            (restaurant) => restaurant.id == id,
            orElse: () => throw Exception('Restaurant not found'),
          );
          emit(RestaurantDetailsLoaded(restaurant: restaurant));
        } catch (e) {
          emit(const RestaurantsError(message: 'Restaurant not found'));
        }
      },
    );
  }

  /// Filter restaurants
  Future<void> filterRestaurants({
    String? city,
    String? cuisineType,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    bool? hasDelivery,
    bool? hasTakeaway,
    bool? hasReservations,
    bool sortByPrice = false,
    bool sortByRating = false,
    bool sortAscending = true,
  }) async {
    emit(RestaurantsLoading());
    final params = FilterParams(
      city: city,
      cuisineType: cuisineType,
      minPrice: minPrice,
      maxPrice: maxPrice,
      minRating: minRating,
      hasDelivery: hasDelivery,
      hasTakeaway: hasTakeaway,
      hasReservations: hasReservations,
      sortByPrice: sortByPrice,
      sortByRating: sortByRating,
      sortAscending: sortAscending,
    );
    final result = await filterRestaurantsUseCase(params);
    result.fold(
      (failure) => emit(RestaurantsError(message: failure.message)),
      (restaurants) => emit(RestaurantsLoaded(restaurants: restaurants)),
    );
  }

  /// Search restaurants
  Future<void> searchRestaurants(String query) async {
    emit(RestaurantsLoading());
    // Implementation would require a specific use case
    // For now, we'll filter the restaurants after fetching all
    final result = await getRestaurantsUseCase(NoParams());
    result.fold(
      (failure) => emit(RestaurantsError(message: failure.message)),
      (restaurants) {
        final filteredRestaurants = restaurants
            .where((restaurant) =>
                restaurant.name.toLowerCase().contains(query.toLowerCase()) ||
                restaurant.description
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                restaurant.location
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                restaurant.cuisineTypes.any((cuisine) =>
                    cuisine.toLowerCase().contains(query.toLowerCase())))
            .toList();
        emit(RestaurantsLoaded(restaurants: filteredRestaurants));
      },
    );
  }
}
