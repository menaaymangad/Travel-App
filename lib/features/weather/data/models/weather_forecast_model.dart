import 'dart:convert';
import '../../domain/entities/weather_forecast.dart';

/// Model class for weather forecast
class WeatherForecastModel extends WeatherForecast {
  /// Creates a new [WeatherForecastModel] instance
  const WeatherForecastModel({
    required String cityName,
    required String countryName,
    required double currentTemp,
    required double feelsLikeTemp,
    required double minTemp,
    required double maxTemp,
    required WeatherConditionType condition,
    required String description,
    required int humidity,
    required double windSpeed,
    required int windDegree,
    required int pressure,
    required int visibility,
    required int sunrise,
    required int sunset,
    required DateTime timestamp,
    required List<DailyForecastModel> dailyForecasts,
  }) : super(
          cityName: cityName,
          countryName: countryName,
          currentTemp: currentTemp,
          feelsLikeTemp: feelsLikeTemp,
          minTemp: minTemp,
          maxTemp: maxTemp,
          condition: condition,
          description: description,
          humidity: humidity,
          windSpeed: windSpeed,
          windDegree: windDegree,
          pressure: pressure,
          visibility: visibility,
          sunrise: sunrise,
          sunset: sunset,
          timestamp: timestamp,
          dailyForecasts: dailyForecasts,
        );

  /// Create a [WeatherForecastModel] from JSON data
  factory WeatherForecastModel.fromJson(Map<String, dynamic> json) {
    // Parse current weather data
    final currentWeather = json['current'];
    final location = json['location'];

    // Parse daily forecasts
    final List<dynamic> forecastDays = json['forecast']['forecastday'];
    final List<DailyForecastModel> dailyForecasts =
        forecastDays.map((day) => DailyForecastModel.fromJson(day)).toList();

    return WeatherForecastModel(
      cityName: location['name'],
      countryName: location['country'],
      currentTemp: currentWeather['temp_c'].toDouble(),
      feelsLikeTemp: currentWeather['feelslike_c'].toDouble(),
      minTemp: dailyForecasts.isNotEmpty ? dailyForecasts[0].minTemp : 0.0,
      maxTemp: dailyForecasts.isNotEmpty ? dailyForecasts[0].maxTemp : 0.0,
      condition: _mapConditionCode(currentWeather['condition']['code']),
      description: currentWeather['condition']['text'],
      humidity: currentWeather['humidity'],
      windSpeed: currentWeather['wind_kph'].toDouble(),
      windDegree: currentWeather['wind_degree'],
      pressure: currentWeather['pressure_mb'].round(),
      visibility: (currentWeather['vis_km'] * 1000).round(),
      sunrise: _parseTimeToUnix(
          json['forecast']['forecastday'][0]['astro']['sunrise']),
      sunset: _parseTimeToUnix(
          json['forecast']['forecastday'][0]['astro']['sunset']),
      timestamp: DateTime.parse(currentWeather['last_updated']),
      dailyForecasts: dailyForecasts,
    );
  }

  /// Convert the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'city_name': cityName,
      'country_name': countryName,
      'current_temp': currentTemp,
      'feels_like_temp': feelsLikeTemp,
      'min_temp': minTemp,
      'max_temp': maxTemp,
      'condition': condition.index,
      'description': description,
      'humidity': humidity,
      'wind_speed': windSpeed,
      'wind_degree': windDegree,
      'pressure': pressure,
      'visibility': visibility,
      'sunrise': sunrise,
      'sunset': sunset,
      'timestamp': timestamp.toIso8601String(),
      'daily_forecasts': (dailyForecasts as List<DailyForecastModel>)
          .map((forecast) => forecast.toJson())
          .toList(),
    };
  }

  /// Map API condition code to [WeatherConditionType]
  static WeatherConditionType _mapConditionCode(int code) {
    // Weather condition codes from WeatherAPI.com
    if (code == 1000) {
      return WeatherConditionType.clear;
    } else if (code >= 1003 && code <= 1009) {
      return WeatherConditionType.cloudy;
    } else if (code >= 1030 && code <= 1039) {
      return WeatherConditionType.foggy;
    } else if ((code >= 1063 && code <= 1069) ||
        (code >= 1150 && code <= 1201) ||
        (code >= 1240 && code <= 1252)) {
      return WeatherConditionType.rainy;
    } else if ((code >= 1087) || (code >= 1273 && code <= 1282)) {
      return WeatherConditionType.thunderstorm;
    } else if ((code >= 1114 && code <= 1117) ||
        (code >= 1204 && code <= 1237) ||
        (code >= 1255 && code <= 1264)) {
      return WeatherConditionType.snowy;
    } else if (code == 1003) {
      return WeatherConditionType.partlyCloudy;
    } else {
      return WeatherConditionType.windy;
    }
  }

  /// Parse time string to Unix timestamp
  static int _parseTimeToUnix(String timeString) {
    // Convert "08:00 AM" format to Unix timestamp
    final now = DateTime.now();
    final parts = timeString.split(' ');
    final timeParts = parts[0].split(':');
    int hour = int.parse(timeParts[0]);
    final int minute = int.parse(timeParts[1]);

    // Handle AM/PM
    if (parts[1] == 'PM' && hour < 12) {
      hour += 12;
    } else if (parts[1] == 'AM' && hour == 12) {
      hour = 0;
    }

    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    return dateTime.millisecondsSinceEpoch ~/ 1000;
  }
}

/// Model class for daily forecast
class DailyForecastModel extends DailyForecast {
  /// Creates a new [DailyForecastModel] instance
  const DailyForecastModel({
    required String day,
    required DateTime date,
    required double maxTemp,
    required double minTemp,
    required WeatherConditionType condition,
    required String description,
    required int humidity,
    required double windSpeed,
    required int precipitationChance,
  }) : super(
          day: day,
          date: date,
          maxTemp: maxTemp,
          minTemp: minTemp,
          condition: condition,
          description: description,
          humidity: humidity,
          windSpeed: windSpeed,
          precipitationChance: precipitationChance,
        );

  /// Create a [DailyForecastModel] from JSON data
  factory DailyForecastModel.fromJson(Map<String, dynamic> json) {
    final day = json['day'];
    final date = DateTime.parse(json['date']);

    return DailyForecastModel(
      day: _getDayName(date),
      date: date,
      maxTemp: day['maxtemp_c'].toDouble(),
      minTemp: day['mintemp_c'].toDouble(),
      condition:
          WeatherForecastModel._mapConditionCode(day['condition']['code']),
      description: day['condition']['text'],
      humidity: day['avghumidity'].round(),
      windSpeed: day['maxwind_kph'].toDouble(),
      precipitationChance: day['daily_chance_of_rain'],
    );
  }

  /// Convert the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'date': date.toIso8601String(),
      'max_temp': maxTemp,
      'min_temp': minTemp,
      'condition': condition.index,
      'description': description,
      'humidity': humidity,
      'wind_speed': windSpeed,
      'precipitation_chance': precipitationChance,
    };
  }

  /// Get the name of the day from a date
  static String _getDayName(DateTime date) {
    final weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    return weekdays[date.weekday - 1];
  }
}
