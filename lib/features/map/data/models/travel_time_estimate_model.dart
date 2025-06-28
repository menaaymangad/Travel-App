import 'package:latlong2/latlong.dart';
import '../../domain/entities/travel_time_estimate.dart';
import 'package:travelapp/features/transport/domain/entities/transport_cost.dart';

/// Model class for travel time estimation
class TravelTimeEstimateModel extends TravelTimeEstimate {
  /// Creates a new [TravelTimeEstimateModel] instance
  const TravelTimeEstimateModel({
    required super.origin,
    required super.originName,
    required super.destination,
    required super.destinationName,
    required super.distanceInKm,
    required super.transportType,
    required super.baseDurationInMinutes,
    required super.trafficCondition,
    required super.weatherCondition,
    required super.trafficDelayInMinutes,
    required super.weatherDelayInMinutes,
  });

  /// Create a [TravelTimeEstimateModel] from a JSON map
  factory TravelTimeEstimateModel.fromJson(Map<String, dynamic> json) {
    return TravelTimeEstimateModel(
      origin: LatLng(
        json['origin']['lat'],
        json['origin']['lng'],
      ),
      originName: json['origin_name'],
      destination: LatLng(
        json['destination']['lat'],
        json['destination']['lng'],
      ),
      destinationName: json['destination_name'],
      distanceInKm: json['distance_km'].toDouble(),
      transportType: _parseTransportType(json['transport_type']),
      baseDurationInMinutes: json['base_duration_minutes'],
      trafficCondition: _parseTrafficCondition(json['traffic_condition']),
      weatherCondition: _parseWeatherCondition(json['weather_condition']),
      trafficDelayInMinutes: json['traffic_delay_minutes'],
      weatherDelayInMinutes: json['weather_delay_minutes'],
    );
  }

  /// Convert the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'origin': {
        'lat': origin.latitude,
        'lng': origin.longitude,
      },
      'origin_name': originName,
      'destination': {
        'lat': destination.latitude,
        'lng': destination.longitude,
      },
      'destination_name': destinationName,
      'distance_km': distanceInKm,
      'transport_type': _transportTypeToString(transportType),
      'base_duration_minutes': baseDurationInMinutes,
      'traffic_condition': _trafficConditionToString(trafficCondition),
      'weather_condition': _weatherConditionToString(weatherCondition),
      'traffic_delay_minutes': trafficDelayInMinutes,
      'weather_delay_minutes': weatherDelayInMinutes,
    };
  }

  /// Parse transport type from string
  static TransportType _parseTransportType(String type) {
    switch (type.toLowerCase()) {
      case 'car':
        return TransportType.car;
      case 'bus':
        return TransportType.bus;
      case 'train':
        return TransportType.train;
      case 'plane':
        return TransportType.plane;
      case 'boat':
        return TransportType.boat;
      case 'walking':
        return TransportType.walking;
      default:
        return TransportType.car;
    }
  }

  /// Convert transport type to string
  static String _transportTypeToString(TransportType type) {
    switch (type) {
      case TransportType.car:
        return 'car';
      case TransportType.bus:
        return 'bus';
      case TransportType.train:
        return 'train';
      case TransportType.plane:
        return 'plane';
      case TransportType.boat:
        return 'boat';
      case TransportType.walking:
        return 'walking';
    }
  }

  /// Parse traffic condition from string
  static TrafficCondition _parseTrafficCondition(String condition) {
    switch (condition.toLowerCase()) {
      case 'light':
        return TrafficCondition.light;
      case 'moderate':
        return TrafficCondition.moderate;
      case 'heavy':
        return TrafficCondition.heavy;
      case 'severe':
        return TrafficCondition.severe;
      default:
        return TrafficCondition.light;
    }
  }

  /// Convert traffic condition to string
  static String _trafficConditionToString(TrafficCondition condition) {
    switch (condition) {
      case TrafficCondition.light:
        return 'light';
      case TrafficCondition.moderate:
        return 'moderate';
      case TrafficCondition.heavy:
        return 'heavy';
      case TrafficCondition.severe:
        return 'severe';
    }
  }

  /// Parse weather condition from string
  static WeatherCondition _parseWeatherCondition(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return WeatherCondition.clear;
      case 'cloudy':
        return WeatherCondition.cloudy;
      case 'rainy':
        return WeatherCondition.rainy;
      case 'stormy':
        return WeatherCondition.stormy;
      case 'snowy':
        return WeatherCondition.snowy;
      default:
        return WeatherCondition.clear;
    }
  }

  /// Convert weather condition to string
  static String _weatherConditionToString(WeatherCondition condition) {
    switch (condition) {
      case WeatherCondition.clear:
        return 'clear';
      case WeatherCondition.cloudy:
        return 'cloudy';
      case WeatherCondition.rainy:
        return 'rainy';
      case WeatherCondition.stormy:
        return 'stormy';
      case WeatherCondition.snowy:
        return 'snowy';
    }
  }
}
