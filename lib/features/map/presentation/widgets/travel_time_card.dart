import 'package:flutter/material.dart';
import 'package:travelapp/features/map/domain/entities/travel_time_estimate.dart';
import 'package:travelapp/features/transport/domain/entities/transport_cost.dart';

/// A card that displays travel time information for a specific transport type
class TravelTimeCard extends StatelessWidget {
  /// The travel time estimate to display
  final TravelTimeEstimate estimate;

  /// Whether this is the fastest transport option
  final bool isFastest;

  /// Creates a new [TravelTimeCard] instance
  const TravelTimeCard({
    Key? key,
    required this.estimate,
    this.isFastest = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isFastest
            ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
            : BorderSide.none,
      ),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const Divider(height: 24),
            _buildTimeDetails(context),
            const SizedBox(height: 16),
            _buildConditions(context),
          ],
        ),
      ),
    );
  }

  /// Build the header section with transport type and total time
  Widget _buildHeader(BuildContext context) {
    final totalDuration = estimate.baseDurationInMinutes +
        estimate.trafficDelayInMinutes +
        estimate.weatherDelayInMinutes;

    final hours = totalDuration ~/ 60;
    final minutes = totalDuration % 60;

    String timeString;
    if (hours > 0) {
      timeString = '$hours h ${minutes > 0 ? '$minutes min' : ''}';
    } else {
      timeString = '$minutes min';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _getTransportIcon(),
            const SizedBox(width: 12),
            Text(
              _getTransportName(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            if (isFastest)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.bolt, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      'Fastest',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(width: 8),
            Text(
              timeString,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Build the time details section with base time and delays
  Widget _buildTimeDetails(BuildContext context) {
    return Column(
      children: [
        _buildTimeRow(
          'Base travel time',
          estimate.baseDurationInMinutes,
          Icons.schedule,
          Colors.blue,
        ),
        if (estimate.trafficDelayInMinutes > 0)
          _buildTimeRow(
            'Traffic delay',
            estimate.trafficDelayInMinutes,
            Icons.traffic,
            Colors.orange,
          ),
        if (estimate.weatherDelayInMinutes > 0)
          _buildTimeRow(
            'Weather delay',
            estimate.weatherDelayInMinutes,
            Icons.wb_cloudy,
            Colors.purple,
          ),
      ],
    );
  }

  /// Build a single time row with label and value
  Widget _buildTimeRow(String label, int minutes, IconData icon, Color color) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;

    String timeString;
    if (hours > 0) {
      timeString = '$hours h ${mins > 0 ? '$mins min' : ''}';
    } else {
      timeString = '$mins min';
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 8),
              Text(label),
            ],
          ),
          Text(
            timeString,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  /// Build the conditions section with traffic and weather info
  Widget _buildConditions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildConditionItem(
            'Traffic',
            _getTrafficText(),
            _getTrafficIcon(),
            _getTrafficColor(),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildConditionItem(
            'Weather',
            _getWeatherText(),
            _getWeatherIcon(),
            _getWeatherColor(),
          ),
        ),
      ],
    );
  }

  /// Build a single condition item with label and value
  Widget _buildConditionItem(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Get the icon for the transport type
  Widget _getTransportIcon() {
    IconData iconData;
    Color iconColor;

    switch (estimate.transportType) {
      case TransportType.car:
        iconData = Icons.directions_car;
        iconColor = Colors.blue;
        break;
      case TransportType.bus:
        iconData = Icons.directions_bus;
        iconColor = Colors.green;
        break;
      case TransportType.train:
        iconData = Icons.train;
        iconColor = Colors.red;
        break;
      case TransportType.plane:
        iconData = Icons.flight;
        iconColor = Colors.purple;
        break;
      case TransportType.boat:
        iconData = Icons.directions_boat;
        iconColor = Colors.blue;
        break;
      case TransportType.walking:
        iconData = Icons.directions_walk;
        iconColor = Colors.orange;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, color: iconColor, size: 24),
    );
  }

  /// Get the name of the transport type
  String _getTransportName() {
    switch (estimate.transportType) {
      case TransportType.car:
        return 'By Car';
      case TransportType.bus:
        return 'By Bus';
      case TransportType.train:
        return 'By Train';
      case TransportType.plane:
        return 'By Plane';
      case TransportType.boat:
        return 'By Boat';
      case TransportType.walking:
        return 'Walking';
    }
  }

  /// Get the text for the traffic condition
  String _getTrafficText() {
    switch (estimate.trafficCondition) {
      case TrafficCondition.light:
        return 'Light';
      case TrafficCondition.moderate:
        return 'Moderate';
      case TrafficCondition.heavy:
        return 'Heavy';
      case TrafficCondition.severe:
        return 'Severe';
    }
  }

  /// Get the icon for the traffic condition
  IconData _getTrafficIcon() {
    switch (estimate.trafficCondition) {
      case TrafficCondition.light:
        return Icons.traffic;
      case TrafficCondition.moderate:
        return Icons.traffic;
      case TrafficCondition.heavy:
        return Icons.traffic;
      case TrafficCondition.severe:
        return Icons.traffic;
    }
  }

  /// Get the color for the traffic condition
  Color _getTrafficColor() {
    switch (estimate.trafficCondition) {
      case TrafficCondition.light:
        return Colors.green;
      case TrafficCondition.moderate:
        return Colors.orange;
      case TrafficCondition.heavy:
        return Colors.deepOrange;
      case TrafficCondition.severe:
        return Colors.red;
    }
  }

  /// Get the text for the weather condition
  String _getWeatherText() {
    switch (estimate.weatherCondition) {
      case WeatherCondition.clear:
        return 'Clear';
      case WeatherCondition.cloudy:
        return 'Cloudy';
      case WeatherCondition.rainy:
        return 'Rainy';
      case WeatherCondition.stormy:
        return 'Stormy';
      case WeatherCondition.snowy:
        return 'Snowy';
    }
  }

  /// Get the icon for the weather condition
  IconData _getWeatherIcon() {
    switch (estimate.weatherCondition) {
      case WeatherCondition.clear:
        return Icons.wb_sunny;
      case WeatherCondition.cloudy:
        return Icons.cloud;
      case WeatherCondition.rainy:
        return Icons.grain;
      case WeatherCondition.stormy:
        return Icons.flash_on;
      case WeatherCondition.snowy:
        return Icons.ac_unit;
    }
  }

  /// Get the color for the weather condition
  Color _getWeatherColor() {
    switch (estimate.weatherCondition) {
      case WeatherCondition.clear:
        return Colors.amber;
      case WeatherCondition.cloudy:
        return Colors.grey;
      case WeatherCondition.rainy:
        return Colors.blue;
      case WeatherCondition.stormy:
        return Colors.purple;
      case WeatherCondition.snowy:
        return Colors.lightBlue;
    }
  }
}
