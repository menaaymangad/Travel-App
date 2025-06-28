import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/weather_forecast_model.dart';

/// Interface for the weather local data source
abstract class WeatherLocalDataSource {
  /// Get cached weather forecast
  Future<WeatherForecastModel> getCachedWeatherForecast();

  /// Cache weather forecast
  Future<void> cacheWeatherForecast(WeatherForecastModel weatherForecast);

  /// Get recently searched cities
  Future<List<String>> getRecentSearches();

  /// Save a city to recent searches
  Future<bool> saveRecentSearch(String cityName);
}

/// Implementation of the weather local data source
class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  /// Shared preferences for local storage
  final SharedPreferences sharedPreferences;

  /// Key for the cached weather forecast
  static const String cachedWeatherKey = 'CACHED_WEATHER_FORECAST';

  /// Key for the recent searches
  static const String recentSearchesKey = 'RECENT_WEATHER_SEARCHES';

  /// Maximum number of recent searches to store
  static const int maxRecentSearches = 10;

  /// Creates a new [WeatherLocalDataSourceImpl] instance
  WeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<WeatherForecastModel> getCachedWeatherForecast() async {
    final jsonString = sharedPreferences.getString(cachedWeatherKey);

    if (jsonString != null) {
      return WeatherForecastModel.fromJson(json.decode(jsonString));
    } else {
      throw CacheException(message: 'No cached weather data found');
    }
  }

  @override
  Future<void> cacheWeatherForecast(
      WeatherForecastModel weatherForecast) async {
    await sharedPreferences.setString(
      cachedWeatherKey,
      json.encode(weatherForecast.toJson()),
    );
  }

  @override
  Future<List<String>> getRecentSearches() async {
    final jsonString = sharedPreferences.getString(recentSearchesKey);

    if (jsonString != null) {
      final List<dynamic> decodedJson = json.decode(jsonString);
      return decodedJson.map((item) => item.toString()).toList();
    } else {
      return [];
    }
  }

  @override
  Future<bool> saveRecentSearch(String cityName) async {
    final currentSearches = await getRecentSearches();

    // Remove if already exists to avoid duplicates
    currentSearches.remove(cityName);

    // Add to the beginning of the list
    currentSearches.insert(0, cityName);

    // Limit the number of recent searches
    if (currentSearches.length > maxRecentSearches) {
      currentSearches.removeLast();
    }

    return sharedPreferences.setString(
      recentSearchesKey,
      json.encode(currentSearches),
    );
  }
}
