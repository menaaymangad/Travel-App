import 'package:equatable/equatable.dart';
import '../../domain/entities/restaurant.dart';

/// Base state for restaurants
abstract class RestaurantsState extends Equatable {
  /// Creates a new [RestaurantsState] instance
  const RestaurantsState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class RestaurantsInitial extends RestaurantsState {}

/// Loading state
class RestaurantsLoading extends RestaurantsState {}

/// Loaded state with restaurants
class RestaurantsLoaded extends RestaurantsState {
  /// List of restaurants
  final List<Restaurant> restaurants;

  /// Creates a new [RestaurantsLoaded] instance
  const RestaurantsLoaded({required this.restaurants});

  @override
  List<Object?> get props => [restaurants];
}

/// Restaurant details loaded state
class RestaurantDetailsLoaded extends RestaurantsState {
  /// Restaurant details
  final Restaurant restaurant;

  /// Creates a new [RestaurantDetailsLoaded] instance
  const RestaurantDetailsLoaded({required this.restaurant});

  @override
  List<Object?> get props => [restaurant];
}

/// Error state
class RestaurantsError extends RestaurantsState {
  /// Error message
  final String message;

  /// Creates a new [RestaurantsError] instance
  const RestaurantsError({required this.message});

  @override
  List<Object?> get props => [message];
}
