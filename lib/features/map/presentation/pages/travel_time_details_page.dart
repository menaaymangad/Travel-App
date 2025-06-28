import 'package:flutter/material.dart';
import 'package:travelapp/features/map/domain/entities/travel_time_estimate.dart';
import 'package:travelapp/features/transport/domain/entities/transport_cost.dart';
import 'package:travelapp/features/transport/presentation/pages/transport_cost_page.dart';

/// A page that displays detailed travel time information for a specific route
class TravelTimeDetailsPage extends StatelessWidget {
  /// The travel time estimate to display
  final TravelTimeEstimate estimate;

  /// Creates a new [TravelTimeDetailsPage] instance
  const TravelTimeDetailsPage({
    Key? key,
    required this.estimate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Time Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildTimeBreakdown(context),
            const SizedBox(height: 24),
            _buildConditionsSection(context),
            const SizedBox(height: 24),
            _buildRouteDetails(context),
            const SizedBox(height: 24),
            _buildCostEstimateButton(context),
          ],
        ),
      ),
    );
  }

  /// Build the header section with origin and destination
  Widget _buildHeader(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _getTransportIcon(),
                const SizedBox(width: 12),
                Text(
                  _getTransportName(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'From',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        estimate.originName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward, color: Colors.grey),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'To',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      Text(
                        estimate.destinationName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoItem(
                  'Distance',
                  '${estimate.distanceInKm.toStringAsFixed(1)} km',
                  Icons.straighten,
                ),
                _buildInfoItem(
                  'Total Time',
                  _formatDuration(estimate.baseDurationInMinutes +
                      estimate.trafficDelayInMinutes +
                      estimate.weatherDelayInMinutes),
                  Icons.access_time,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build a single info item with label and value
  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  /// Build the time breakdown section
  Widget _buildTimeBreakdown(BuildContext context) {
    final totalMinutes = estimate.baseDurationInMinutes +
        estimate.trafficDelayInMinutes +
        estimate.weatherDelayInMinutes;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Time Breakdown',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildProgressBar(context, totalMinutes),
            const SizedBox(height: 16),
            _buildTimeRow(
              'Base travel time',
              estimate.baseDurationInMinutes,
              Icons.schedule,
              Colors.blue,
              totalMinutes,
            ),
            if (estimate.trafficDelayInMinutes > 0)
              _buildTimeRow(
                'Traffic delay',
                estimate.trafficDelayInMinutes,
                Icons.traffic,
                Colors.orange,
                totalMinutes,
              ),
            if (estimate.weatherDelayInMinutes > 0)
              _buildTimeRow(
                'Weather delay',
                estimate.weatherDelayInMinutes,
                Icons.wb_cloudy,
                Colors.purple,
                totalMinutes,
              ),
            const Divider(height: 24),
            _buildTotalTimeRow(totalMinutes),
          ],
        ),
      ),
    );
  }

  /// Build the progress bar showing the time breakdown
  Widget _buildProgressBar(BuildContext context, int totalMinutes) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 16,
            child: Row(
              children: [
                _buildProgressSegment(
                  estimate.baseDurationInMinutes / totalMinutes,
                  Colors.blue,
                ),
                _buildProgressSegment(
                  estimate.trafficDelayInMinutes / totalMinutes,
                  Colors.orange,
                ),
                _buildProgressSegment(
                  estimate.weatherDelayInMinutes / totalMinutes,
                  Colors.purple,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '0 min',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            Text(
              '$totalMinutes min',
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

  /// Build a segment of the progress bar
  Widget _buildProgressSegment(double fraction, Color color) {
    if (fraction <= 0) return const SizedBox.shrink();

    return Expanded(
      flex: (fraction * 100).round(),
      child: Container(
        color: color,
      ),
    );
  }

  /// Build a single time row with label and value
  Widget _buildTimeRow(
    String label,
    int minutes,
    IconData icon,
    Color color,
    int totalMinutes,
  ) {
    final percentage = (minutes / totalMinutes * 100).round();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(label),
          ),
          Text(
            _formatDuration(minutes),
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build the total time row
  Widget _buildTotalTimeRow(int totalMinutes) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Total travel time',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Text(
          _formatDuration(totalMinutes),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  /// Build the conditions section with traffic and weather info
  Widget _buildConditionsSection(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Travel Conditions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildConditionCard(
                    context,
                    'Traffic',
                    _getTrafficText(),
                    _getTrafficDescription(),
                    _getTrafficIcon(),
                    _getTrafficColor(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildConditionCard(
                    context,
                    'Weather',
                    _getWeatherText(),
                    _getWeatherDescription(),
                    _getWeatherIcon(),
                    _getWeatherColor(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build a single condition card
  Widget _buildConditionCard(
    BuildContext context,
    String label,
    String value,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: color),
              const SizedBox(width: 8),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.grey,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Build the route details section
  Widget _buildRouteDetails(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Route Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.speed, color: Colors.blue),
              title: const Text('Average Speed'),
              trailing: Text(
                '${_calculateAverageSpeed().toStringAsFixed(0)} km/h',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.straighten, color: Colors.blue),
              title: const Text('Distance'),
              trailing: Text(
                '${estimate.distanceInKm.toStringAsFixed(1)} km',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            if (_hasStops())
              ListTile(
                leading: const Icon(Icons.place, color: Colors.blue),
                title: const Text('Stops'),
                trailing: Text(
                  _getStopsCount(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Build the cost estimate button
  Widget _buildCostEstimateButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransportCostPage(),
            ),
          );
        },
        icon: const Icon(Icons.attach_money),
        label: const Text('Estimate Trip Cost'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, color: iconColor, size: 32),
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

  /// Format duration in minutes to a readable string
  String _formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;

    if (hours > 0) {
      return '$hours h ${mins > 0 ? '$mins min' : ''}';
    } else {
      return '$mins min';
    }
  }

  /// Get the text for the traffic condition
  String _getTrafficText() {
    switch (estimate.trafficCondition) {
      case TrafficCondition.light:
        return 'Light Traffic';
      case TrafficCondition.moderate:
        return 'Moderate Traffic';
      case TrafficCondition.heavy:
        return 'Heavy Traffic';
      case TrafficCondition.severe:
        return 'Severe Traffic';
    }
  }

  /// Get the description for the traffic condition
  String _getTrafficDescription() {
    switch (estimate.trafficCondition) {
      case TrafficCondition.light:
        return 'Minimal delay expected';
      case TrafficCondition.moderate:
        return 'Some congestion, moderate delays';
      case TrafficCondition.heavy:
        return 'Significant congestion, expect delays';
      case TrafficCondition.severe:
        return 'Major congestion, substantial delays';
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

  /// Get the description for the weather condition
  String _getWeatherDescription() {
    switch (estimate.weatherCondition) {
      case WeatherCondition.clear:
        return 'Optimal travel conditions';
      case WeatherCondition.cloudy:
        return 'Good visibility, minimal impact';
      case WeatherCondition.rainy:
        return 'Reduced visibility, slower speeds';
      case WeatherCondition.stormy:
        return 'Poor conditions, significant delays';
      case WeatherCondition.snowy:
        return 'Hazardous conditions, major delays';
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

  /// Calculate the average speed in km/h
  double _calculateAverageSpeed() {
    final totalMinutes = estimate.baseDurationInMinutes +
        estimate.trafficDelayInMinutes +
        estimate.weatherDelayInMinutes;

    if (totalMinutes <= 0) return 0;

    // Convert minutes to hours and calculate speed
    return estimate.distanceInKm / (totalMinutes / 60);
  }

  /// Check if the transport type has stops
  bool _hasStops() {
    return estimate.transportType == TransportType.bus ||
        estimate.transportType == TransportType.train;
  }

  /// Get the number of stops for the transport type
  String _getStopsCount() {
    // This would be dynamic in a real app
    switch (estimate.transportType) {
      case TransportType.bus:
        return '${(estimate.distanceInKm / 5).round()} stops';
      case TransportType.train:
        return '${(estimate.distanceInKm / 30).round()} stops';
      default:
        return 'None';
    }
  }
}
