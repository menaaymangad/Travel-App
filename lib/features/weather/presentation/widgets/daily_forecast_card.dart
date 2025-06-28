import 'package:flutter/material.dart';
import '../../domain/entities/weather_forecast.dart';

/// A card that displays daily weather forecast information
class DailyForecastCard extends StatelessWidget {
  /// The daily forecast to display
  final DailyForecast forecast;

  /// Whether this is today's forecast
  final bool isToday;

  /// Creates a new [DailyForecastCard] instance
  const DailyForecastCard({
    Key? key,
    required this.forecast,
    this.isToday = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              isToday ? 'Today' : forecast.day,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _getWeatherIcon(forecast.condition),
            const SizedBox(height: 8),
            Text(
              '${forecast.maxTemp.round()}°',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              '${forecast.minTemp.round()}°',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.water_drop,
                  size: 12,
                  color: Colors.blue,
                ),
                const SizedBox(width: 4),
                Text(
                  '${forecast.precipitationChance}%',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Get the icon for the weather condition
  Widget _getWeatherIcon(WeatherConditionType condition) {
    IconData iconData;
    Color iconColor;

    switch (condition) {
      case WeatherConditionType.clear:
        iconData = Icons.wb_sunny;
        iconColor = Colors.amber;
        break;
      case WeatherConditionType.partlyCloudy:
        iconData = Icons.wb_cloudy;
        iconColor = Colors.amber.shade300;
        break;
      case WeatherConditionType.cloudy:
        iconData = Icons.cloud;
        iconColor = Colors.grey;
        break;
      case WeatherConditionType.rainy:
        iconData = Icons.grain;
        iconColor = Colors.blue;
        break;
      case WeatherConditionType.thunderstorm:
        iconData = Icons.flash_on;
        iconColor = Colors.deepPurple;
        break;
      case WeatherConditionType.snowy:
        iconData = Icons.ac_unit;
        iconColor = Colors.lightBlue;
        break;
      case WeatherConditionType.foggy:
        iconData = Icons.cloud_queue;
        iconColor = Colors.blueGrey;
        break;
      case WeatherConditionType.windy:
        iconData = Icons.air;
        iconColor = Colors.blueGrey;
        break;
    }

    return Icon(
      iconData,
      color: iconColor,
      size: 32,
    );
  }
}
