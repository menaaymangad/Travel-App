import 'package:equatable/equatable.dart';
import '../../domain/entities/weather_forecast.dart';

/// Base state for weather-related states
abstract class WeatherState extends Equatable {
  /// Creates a new [WeatherState] instance
  const WeatherState();

  @override
  List<Object?> get props => [];
}

/// Initial state for weather
class WeatherInitial extends WeatherState {}

/// State when weather data is loading
class WeatherLoading extends WeatherState {}

/// State when weather forecast has been loaded
class WeatherLoaded extends WeatherState {
  /// The loaded weather forecast
  final WeatherForecast weatherForecast;

  /// Creates a new [WeatherLoaded] instance
  const WeatherLoaded(this.weatherForecast);

  @override
  List<Object?> get props => [weatherForecast];
}

/// State when city search results have been loaded
class CitiesLoaded extends WeatherState {
  /// The loaded city search results
  final List<String> cities;

  /// Creates a new [CitiesLoaded] instance
  const CitiesLoaded(this.cities);

  @override
  List<Object?> get props => [cities];
}

/// State when recent searches have been loaded
class RecentSearchesLoaded extends WeatherState {
  /// The loaded recent searches
  final List<String> recentSearches;

  /// Creates a new [RecentSearchesLoaded] instance
  const RecentSearchesLoaded(this.recentSearches);

  @override
  List<Object?> get props => [recentSearches];
}

/// State when an error occurs
class WeatherError extends WeatherState {
  /// The error message
  final String message;

  /// Creates a new [WeatherError] instance
  const WeatherError(this.message);

  @override
  List<Object?> get props => [message];
}
