import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../models/weather_forecast_model.dart';

/// Interface for the weather remote data source
abstract class WeatherRemoteDataSource {
  /// Get weather forecast for a specific city
  Future<WeatherForecastModel> getWeatherForecast(String cityName);

  /// Get weather forecast for current location
  Future<WeatherForecastModel> getWeatherForecastByLocation(
    double latitude,
    double longitude,
  );

  /// Search for cities by name
  Future<List<String>> searchCities(String query);
}

/// Implementation of the weather remote data source
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  /// HTTP client for API requests
  final http.Client client;

  /// Weather API key
  final String apiKey;

  /// Base URL for the weather API
  final String baseUrl;

  /// Creates a new [WeatherRemoteDataSourceImpl] instance
  WeatherRemoteDataSourceImpl({
    required this.client,
    required this.apiKey,
    this.baseUrl = 'https://api.weatherapi.com/v1',
  });

  @override
  Future<WeatherForecastModel> getWeatherForecast(String cityName) async {
    final url = Uri.parse(
      '$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=7&aqi=no&alerts=no',
    );

    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return WeatherForecastModel.fromJson(json.decode(response.body));
    } else {
      final errorJson = json.decode(response.body);
      throw ServerException(
        message:
            errorJson['error']['message'] ?? 'Failed to fetch weather data',
      );
    }
  }

  @override
  Future<WeatherForecastModel> getWeatherForecastByLocation(
    double latitude,
    double longitude,
  ) async {
    final url = Uri.parse(
      '$baseUrl/forecast.json?key=$apiKey&q=$latitude,$longitude&days=7&aqi=no&alerts=no',
    );

    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return WeatherForecastModel.fromJson(json.decode(response.body));
    } else {
      final errorJson = json.decode(response.body);
      throw ServerException(
        message:
            errorJson['error']['message'] ?? 'Failed to fetch weather data',
      );
    }
  }

  @override
  Future<List<String>> searchCities(String query) async {
    final url = Uri.parse(
      '$baseUrl/search.json?key=$apiKey&q=$query',
    );

    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> citiesJson = json.decode(response.body);
      return citiesJson
          .map((city) => '${city['name']}, ${city['country']}')
          .toList();
    } else {
      final errorJson = json.decode(response.body);
      throw ServerException(
        message: errorJson['error']['message'] ?? 'Failed to search cities',
      );
    }
  }
}
