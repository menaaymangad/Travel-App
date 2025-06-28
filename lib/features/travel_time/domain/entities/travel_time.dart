import 'package:equatable/equatable.dart';
import 'package:travelapp/features/transport/domain/entities/transport_cost.dart';

/// Entity representing travel time information
class TravelTime extends Equatable {
  /// Origin location name
  final String origin;

  /// Destination location name
  final String destination;

  /// Distance in kilometers
  final double distanceInKm;

  /// Type of transport
  final TransportType transportType;

  /// Estimated travel time in minutes
  final int durationInMinutes;

  /// Traffic condition
  final TrafficCondition trafficCondition;

  /// Weather condition
  final WeatherCondition weatherCondition;

  /// Estimated delay in minutes
  final int estimatedDelayInMinutes;

  /// Total estimated travel time in minutes (including delays)
  int get totalDurationInMinutes => durationInMinutes + estimatedDelayInMinutes;

  /// Creates a new [TravelTime] instance
  const TravelTime({
    required this.origin,
    required this.destination,
    required this.distanceInKm,
    required this.transportType,
    required this.durationInMinutes,
    required this.trafficCondition,
    required this.weatherCondition,
    required this.estimatedDelayInMinutes,
  });

  @override
  List<Object?> get props => [
        origin,
        destination,
        distanceInKm,
        transportType,
        durationInMinutes,
        trafficCondition,
        weatherCondition,
        estimatedDelayInMinutes,
      ];

  /// Get the transport type as a readable string
  String get transportTypeString {
    switch (transportType) {
      case TransportType.car:
        return 'Car';
      case TransportType.bus:
        return 'Bus';
      case TransportType.train:
        return 'Train';
      case TransportType.plane:
        return 'Plane';
      case TransportType.boat:
        return 'Boat';
      case TransportType.walking:
        return 'Walking';
    }
  }

  /// Get the formatted duration string
  String get durationString {
    if (durationInMinutes < 60) {
      return '$durationInMinutes min';
    } else {
      final hours = durationInMinutes ~/ 60;
      final minutes = durationInMinutes % 60;
      return '$hours h ${minutes > 0 ? '$minutes min' : ''}';
    }
  }

  /// Get the formatted total duration string
  String get totalDurationString {
    if (totalDurationInMinutes < 60) {
      return '$totalDurationInMinutes min';
    } else {
      final hours = totalDurationInMinutes ~/ 60;
      final minutes = totalDurationInMinutes % 60;
      return '$hours h ${minutes > 0 ? '$minutes min' : ''}';
    }
  }

  /// Get the traffic condition as a readable string
  String get trafficConditionString {
    switch (trafficCondition) {
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

  /// Get the weather condition as a readable string
  String get weatherConditionString {
    switch (weatherCondition) {
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
}

/// Enum representing different traffic conditions
enum TrafficCondition {
  /// Light traffic
  light,

  /// Moderate traffic
  moderate,

  /// Heavy traffic
  heavy,

  /// Severe traffic
  severe
}

/// Enum representing different weather conditions
enum WeatherCondition {
  /// Clear weather
  clear,

  /// Cloudy weather
  cloudy,

  /// Rainy weather
  rainy,

  /// Stormy weather
  stormy,

  /// Snowy weather
  snowy
}
