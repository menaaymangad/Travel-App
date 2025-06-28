import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:travelapp/features/transport/domain/entities/transport_cost.dart';

/// Entity representing travel time estimation information
class TravelTimeEstimate extends Equatable {
  /// Origin location
  final LatLng origin;

  /// Destination location
  final String originName;

  /// Origin location name
  final LatLng destination;

  /// Destination location name
  final String destinationName;

  /// Distance in kilometers
  final double distanceInKm;

  /// Type of transport
  final TransportType transportType;

  /// Base travel time in minutes (without traffic/weather)
  final int baseDurationInMinutes;

  /// Traffic condition
  final TrafficCondition trafficCondition;

  /// Weather condition
  final WeatherCondition weatherCondition;

  /// Traffic delay in minutes
  final int trafficDelayInMinutes;

  /// Weather delay in minutes
  final int weatherDelayInMinutes;

  /// Total estimated travel time in minutes (including delays)
  int get totalDurationInMinutes =>
      baseDurationInMinutes + trafficDelayInMinutes + weatherDelayInMinutes;

  /// Creates a new [TravelTimeEstimate] instance
  const TravelTimeEstimate({
    required this.origin,
    required this.originName,
    required this.destination,
    required this.destinationName,
    required this.distanceInKm,
    required this.transportType,
    required this.baseDurationInMinutes,
    required this.trafficCondition,
    required this.weatherCondition,
    required this.trafficDelayInMinutes,
    required this.weatherDelayInMinutes,
  });

  @override
  List<Object?> get props => [
        origin,
        originName,
        destination,
        destinationName,
        distanceInKm,
        transportType,
        baseDurationInMinutes,
        trafficCondition,
        weatherCondition,
        trafficDelayInMinutes,
        weatherDelayInMinutes,
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

  /// Get the formatted base duration string
  String get baseDurationString {
    if (baseDurationInMinutes < 60) {
      return '$baseDurationInMinutes min';
    } else {
      final hours = baseDurationInMinutes ~/ 60;
      final minutes = baseDurationInMinutes % 60;
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
