import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/weather_forecast.dart';

/// Repository interface for weather forecasts
abstract class WeatherRepository {
  /// Get weather forecast for a specific city
  Future<Either<Failure, WeatherForecast>> getWeatherForecast(String cityName);

  /// Get weather forecast for current location
  Future<Either<Failure, WeatherForecast>> getWeatherForecastByLocation(
    double latitude,
    double longitude,
  );

  /// Search for cities by name
  Future<Either<Failure, List<String>>> searchCities(String query);

  /// Get recently searched cities
  Future<Either<Failure, List<String>>> getRecentSearches();

  /// Save a city to recent searches
  Future<Either<Failure, bool>> saveRecentSearch(String cityName);
}
