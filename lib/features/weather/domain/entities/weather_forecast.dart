import 'package:equatable/equatable.dart';

/// Weather condition types
enum WeatherConditionType {
  clear,
  partlyCloudy,
  cloudy,
  rainy,
  thunderstorm,
  snowy,
  foggy,
  windy,
}

/// Weather forecast entity
class WeatherForecast extends Equatable {
  /// City name
  final String cityName;

  /// Country name
  final String countryName;

  /// Current temperature in Celsius
  final double currentTemp;

  /// Feels like temperature in Celsius
  final double feelsLikeTemp;

  /// Minimum temperature in Celsius
  final double minTemp;

  /// Maximum temperature in Celsius
  final double maxTemp;

  /// Current weather condition
  final WeatherConditionType condition;

  /// Weather description
  final String description;

  /// Humidity percentage
  final int humidity;

  /// Wind speed in km/h
  final double windSpeed;

  /// Wind direction in degrees
  final int windDegree;

  /// Atmospheric pressure in hPa
  final int pressure;

  /// Visibility in meters
  final int visibility;

  /// Sunrise time in Unix timestamp
  final int sunrise;

  /// Sunset time in Unix timestamp
  final int sunset;

  /// Timestamp of the forecast
  final DateTime timestamp;

  /// Daily forecasts for the next days
  final List<DailyForecast> dailyForecasts;

  /// Creates a new [WeatherForecast] instance
  const WeatherForecast({
    required this.cityName,
    required this.countryName,
    required this.currentTemp,
    required this.feelsLikeTemp,
    required this.minTemp,
    required this.maxTemp,
    required this.condition,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.windDegree,
    required this.pressure,
    required this.visibility,
    required this.sunrise,
    required this.sunset,
    required this.timestamp,
    required this.dailyForecasts,
  });

  @override
  List<Object?> get props => [
        cityName,
        countryName,
        currentTemp,
        feelsLikeTemp,
        minTemp,
        maxTemp,
        condition,
        description,
        humidity,
        windSpeed,
        windDegree,
        pressure,
        visibility,
        sunrise,
        sunset,
        timestamp,
        dailyForecasts,
      ];
}

/// Daily weather forecast entity
class DailyForecast extends Equatable {
  /// Day of the week
  final String day;

  /// Date of the forecast
  final DateTime date;

  /// Maximum temperature in Celsius
  final double maxTemp;

  /// Minimum temperature in Celsius
  final double minTemp;

  /// Weather condition
  final WeatherConditionType condition;

  /// Weather description
  final String description;

  /// Humidity percentage
  final int humidity;

  /// Wind speed in km/h
  final double windSpeed;

  /// Chance of precipitation in percentage
  final int precipitationChance;

  /// Creates a new [DailyForecast] instance
  const DailyForecast({
    required this.day,
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.precipitationChance,
  });

  @override
  List<Object?> get props => [
        day,
        date,
        maxTemp,
        minTemp,
        condition,
        description,
        humidity,
        windSpeed,
        precipitationChance,
      ];
}
