import 'package:flutter/material.dart';
import '../../domain/entities/weather_forecast.dart';

/// A card that displays current weather information
class WeatherCard extends StatelessWidget {
  /// The weather forecast to display
  final WeatherForecast forecast;

  /// Whether to show detailed information
  final bool showDetails;

  /// Creates a new [WeatherCard] instance
  const WeatherCard({
    Key? key,
    required this.forecast,
    this.showDetails = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const Divider(height: 24),
            _buildCurrentWeather(context),
            if (showDetails) ...[
              const SizedBox(height: 16),
              _buildDetails(context),
            ],
          ],
        ),
      ),
    );
  }

  /// Build the header with location and time
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              forecast.cityName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              forecast.countryName,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        Text(
          _formatDateTime(forecast.timestamp),
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  /// Build the current weather section
  Widget _buildCurrentWeather(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _getWeatherIcon(forecast.condition),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${forecast.currentTemp.round()}°C',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  forecast.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'H: ${forecast.maxTemp.round()}°C',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'L: ${forecast.minTemp.round()}°C',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Feels like: ${forecast.feelsLikeTemp.round()}°C',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Build the details section
  Widget _buildDetails(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDetailItem(
              context,
              'Humidity',
              '${forecast.humidity}%',
              Icons.water_drop_outlined,
            ),
            _buildDetailItem(
              context,
              'Wind',
              '${forecast.windSpeed} km/h',
              Icons.air_outlined,
            ),
            _buildDetailItem(
              context,
              'Pressure',
              '${forecast.pressure} hPa',
              Icons.speed_outlined,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDetailItem(
              context,
              'Visibility',
              '${(forecast.visibility / 1000).toStringAsFixed(1)} km',
              Icons.visibility_outlined,
            ),
            _buildDetailItem(
              context,
              'Sunrise',
              _formatTime(forecast.sunrise),
              Icons.wb_sunny_outlined,
            ),
            _buildDetailItem(
              context,
              'Sunset',
              _formatTime(forecast.sunset),
              Icons.nightlight_round_outlined,
            ),
          ],
        ),
      ],
    );
  }

  /// Build a single detail item
  Widget _buildDetailItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: Theme.of(context).primaryColor,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
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

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 32,
      ),
    );
  }

  /// Format a Unix timestamp to a time string
  String _formatTime(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  /// Format a DateTime to a string
  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return 'Today, ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else {
      return '${dateTime.day}/${dateTime.month}, ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }
}
