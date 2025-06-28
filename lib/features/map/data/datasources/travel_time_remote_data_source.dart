import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import '../../domain/entities/travel_time_estimate.dart';
import '../models/travel_time_estimate_model.dart';
import 'package:travelapp/features/transport/domain/entities/transport_cost.dart';

/// Interface for the travel time remote data source
abstract class TravelTimeRemoteDataSource {
  /// Estimate travel time between two locations
  Future<TravelTimeEstimateModel> estimateTravelTime(
    LatLng origin,
    LatLng destination,
    TransportType transportType,
  );

  /// Estimate travel time between two locations by place names
  Future<TravelTimeEstimateModel> estimateTravelTimeByPlaceNames(
    String originName,
    String destinationName,
    TransportType transportType,
  );

  /// Get current traffic conditions for a route
  Future<TrafficCondition> getTrafficCondition(
    LatLng origin,
    LatLng destination,
  );

  /// Get current weather conditions for a location
  Future<WeatherCondition> getWeatherCondition(
    LatLng location,
  );
}

/// Implementation of the travel time remote data source
class TravelTimeRemoteDataSourceImpl implements TravelTimeRemoteDataSource {
  /// HTTP client for API requests
  final http.Client client;

  /// Google Maps API key
  final String apiKey;

  /// Weather API key
  final String weatherApiKey;

  /// Creates a new [TravelTimeRemoteDataSourceImpl] instance
  TravelTimeRemoteDataSourceImpl({
    required this.client,
    required this.apiKey,
    required this.weatherApiKey,
  });

  @override
  Future<TravelTimeEstimateModel> estimateTravelTime(
    LatLng origin,
    LatLng destination,
    TransportType transportType,
  ) async {
    // In a real app, this would make API calls to Google Maps Distance Matrix API
    // and a weather API to get real-time data
    // For now, we'll simulate the response

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Calculate distance
    final distanceInKm = _calculateDistance(origin, destination);

    // Get traffic and weather conditions
    final trafficCondition = await getTrafficCondition(origin, destination);
    final weatherCondition = await getWeatherCondition(destination);

    // Calculate base duration based on transport type and distance
    final baseDurationInMinutes = _calculateBaseDuration(
      distanceInKm,
      transportType,
    );

    // Calculate delays based on traffic and weather
    final trafficDelayInMinutes = _calculateTrafficDelay(
      baseDurationInMinutes,
      trafficCondition,
      transportType,
    );

    final weatherDelayInMinutes = _calculateWeatherDelay(
      baseDurationInMinutes,
      weatherCondition,
      transportType,
    );

    return TravelTimeEstimateModel(
      origin: origin,
      originName: await _getPlaceName(origin),
      destination: destination,
      destinationName: await _getPlaceName(destination),
      distanceInKm: distanceInKm,
      transportType: transportType,
      baseDurationInMinutes: baseDurationInMinutes,
      trafficCondition: trafficCondition,
      weatherCondition: weatherCondition,
      trafficDelayInMinutes: trafficDelayInMinutes,
      weatherDelayInMinutes: weatherDelayInMinutes,
    );
  }

  @override
  Future<TravelTimeEstimateModel> estimateTravelTimeByPlaceNames(
    String originName,
    String destinationName,
    TransportType transportType,
  ) async {
    // In a real app, this would geocode the place names to coordinates
    // For now, we'll use mock coordinates

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock geocoding
    final originCoords = await _geocodePlaceName(originName);
    final destinationCoords = await _geocodePlaceName(destinationName);

    return estimateTravelTime(
      originCoords,
      destinationCoords,
      transportType,
    );
  }

  @override
  Future<TrafficCondition> getTrafficCondition(
    LatLng origin,
    LatLng destination,
  ) async {
    // In a real app, this would make an API call to get traffic conditions
    // For now, we'll return a random traffic condition

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Generate a random traffic condition based on time of day
    final hour = DateTime.now().hour;

    if (hour >= 7 && hour <= 9 || hour >= 16 && hour <= 19) {
      // Rush hour - higher chance of heavy traffic
      final random = DateTime.now().millisecond % 100;
      if (random < 40) {
        return TrafficCondition.heavy;
      } else if (random < 70) {
        return TrafficCondition.moderate;
      } else if (random < 90) {
        return TrafficCondition.severe;
      } else {
        return TrafficCondition.light;
      }
    } else {
      // Non-rush hour - higher chance of light traffic
      final random = DateTime.now().millisecond % 100;
      if (random < 60) {
        return TrafficCondition.light;
      } else if (random < 85) {
        return TrafficCondition.moderate;
      } else if (random < 95) {
        return TrafficCondition.heavy;
      } else {
        return TrafficCondition.severe;
      }
    }
  }

  @override
  Future<WeatherCondition> getWeatherCondition(LatLng location) async {
    // In a real app, this would make an API call to a weather service
    // For now, we'll return a random weather condition

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Generate a random weather condition
    final random = DateTime.now().millisecond % 100;

    if (random < 50) {
      return WeatherCondition.clear;
    } else if (random < 75) {
      return WeatherCondition.cloudy;
    } else if (random < 90) {
      return WeatherCondition.rainy;
    } else if (random < 95) {
      return WeatherCondition.stormy;
    } else {
      return WeatherCondition.snowy;
    }
  }

  /// Calculate distance between two coordinates in kilometers
  double _calculateDistance(LatLng origin, LatLng destination) {
    // In a real app, this would use the Haversine formula or call an API
    // For now, we'll use a simplified approximation

    const earthRadius = 6371.0; // in kilometers

    final lat1 = origin.latitude * (math.pi / 180);
    final lon1 = origin.longitude * (math.pi / 180);
    final lat2 = destination.latitude * (math.pi / 180);
    final lon2 = destination.longitude * (math.pi / 180);

    final dLat = lat2 - lat1;
    final dLon = lon2 - lon1;

    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.sin(dLon / 2) *
            math.sin(dLon / 2) *
            math.cos(lat1) *
            math.cos(lat2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadius * c;
  }

  /// Calculate base duration based on transport type and distance
  int _calculateBaseDuration(double distanceInKm, TransportType transportType) {
    // Average speeds in km/h for different transport types
    switch (transportType) {
      case TransportType.car:
        return (distanceInKm / 60 * 60).round(); // 60 km/h
      case TransportType.bus:
        return (distanceInKm / 40 * 60).round(); // 40 km/h
      case TransportType.train:
        return (distanceInKm / 80 * 60).round(); // 80 km/h
      case TransportType.plane:
        // For plane, add 2 hours for boarding, takeoff, landing, etc.
        return (distanceInKm / 800 * 60).round() + 120; // 800 km/h
      case TransportType.boat:
        return (distanceInKm / 30 * 60).round(); // 30 km/h
      case TransportType.walking:
        return (distanceInKm / 5 * 60).round(); // 5 km/h
    }
  }

  /// Calculate traffic delay based on base duration, traffic condition, and transport type
  int _calculateTrafficDelay(
    int baseDurationInMinutes,
    TrafficCondition trafficCondition,
    TransportType transportType,
  ) {
    // Only car and bus are affected by traffic
    if (transportType != TransportType.car &&
        transportType != TransportType.bus) {
      return 0;
    }

    // Delay factor based on traffic condition
    double delayFactor;
    switch (trafficCondition) {
      case TrafficCondition.light:
        delayFactor = 0.1; // 10% delay
        break;
      case TrafficCondition.moderate:
        delayFactor = 0.3; // 30% delay
        break;
      case TrafficCondition.heavy:
        delayFactor = 0.6; // 60% delay
        break;
      case TrafficCondition.severe:
        delayFactor = 1.0; // 100% delay (double the time)
        break;
    }

    return (baseDurationInMinutes * delayFactor).round();
  }

  /// Calculate weather delay based on base duration, weather condition, and transport type
  int _calculateWeatherDelay(
    int baseDurationInMinutes,
    WeatherCondition weatherCondition,
    TransportType transportType,
  ) {
    // Delay factor based on weather condition and transport type
    double delayFactor;

    switch (weatherCondition) {
      case WeatherCondition.clear:
        delayFactor = 0.0; // No delay
        break;
      case WeatherCondition.cloudy:
        // Slight delay for planes
        delayFactor = transportType == TransportType.plane ? 0.1 : 0.0;
        break;
      case WeatherCondition.rainy:
        // Moderate delay for cars, buses, walking
        if (transportType == TransportType.car ||
            transportType == TransportType.bus ||
            transportType == TransportType.walking) {
          delayFactor = 0.2;
        } else if (transportType == TransportType.plane) {
          delayFactor = 0.3;
        } else {
          delayFactor = 0.1;
        }
        break;
      case WeatherCondition.stormy:
        // Significant delay for all transport types
        if (transportType == TransportType.plane) {
          delayFactor = 0.8; // Planes are heavily affected
        } else if (transportType == TransportType.boat) {
          delayFactor = 0.7; // Boats are heavily affected
        } else {
          delayFactor = 0.4;
        }
        break;
      case WeatherCondition.snowy:
        // Major delay for road transport
        if (transportType == TransportType.car ||
            transportType == TransportType.bus ||
            transportType == TransportType.walking) {
          delayFactor = 0.6;
        } else if (transportType == TransportType.plane) {
          delayFactor = 0.7;
        } else {
          delayFactor = 0.3;
        }
        break;
    }

    return (baseDurationInMinutes * delayFactor).round();
  }

  /// Get place name from coordinates
  Future<String> _getPlaceName(LatLng coords) async {
    // In a real app, this would use the Google Maps Geocoding API
    // For now, we'll return mock names based on coordinates

    // Mock place names for common Egyptian coordinates
    final mockPlaces = {
      '30.033333,31.233334': 'Cairo',
      '29.9773,31.1325': 'Giza',
      '25.6872,32.6396': 'Luxor',
      '24.0889,32.8998': 'Aswan',
      '31.2001,29.9187': 'Alexandria',
      '27.9158,34.3300': 'Sharm El Sheikh',
      '27.2579,33.8116': 'Hurghada',
    };

    // Check if we have a mock name for these coordinates
    final key = '${coords.latitude},${coords.longitude}';
    if (mockPlaces.containsKey(key)) {
      return mockPlaces[key]!;
    }

    // If not, return a generic name with the coordinates
    return 'Location (${coords.latitude.toStringAsFixed(4)}, ${coords.longitude.toStringAsFixed(4)})';
  }

  /// Geocode a place name to coordinates
  Future<LatLng> _geocodePlaceName(String placeName) async {
    // In a real app, this would use the Google Maps Geocoding API
    // For now, we'll return mock coordinates based on place names

    // Mock coordinates for common Egyptian cities
    final mockCoordinates = {
      'cairo': const LatLng(30.033333, 31.233334),
      'giza': const LatLng(29.9773, 31.1325),
      'luxor': const LatLng(25.6872, 32.6396),
      'aswan': const LatLng(24.0889, 32.8998),
      'alexandria': const LatLng(31.2001, 29.9187),
      'sharm el sheikh': const LatLng(27.9158, 34.3300),
      'hurghada': const LatLng(27.2579, 33.8116),
    };

    // Check if we have mock coordinates for this place name
    final key = placeName.toLowerCase();
    if (mockCoordinates.containsKey(key)) {
      return mockCoordinates[key]!;
    }

    // If not, return default coordinates (Cairo)
    return const LatLng(30.033333, 31.233334);
  }
}
