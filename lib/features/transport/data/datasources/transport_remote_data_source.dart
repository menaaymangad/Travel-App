import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/transport_cost.dart';
import '../models/transport_cost_model.dart';

/// Interface for the transport remote data source
abstract class TransportRemoteDataSource {
  /// Calculate transport cost between two locations
  Future<List<TransportCostModel>> calculateTransportCost(
    String origin,
    String destination,
  );

  /// Get available transport types between two locations
  Future<List<TransportType>> getAvailableTransportTypes(
    String origin,
    String destination,
  );

  /// Get transport cost for a specific transport type
  Future<TransportCostModel> getTransportCostByType(
    String origin,
    String destination,
    TransportType transportType,
  );
}

/// Implementation of the transport remote data source
class TransportRemoteDataSourceImpl implements TransportRemoteDataSource {
  /// HTTP client for API requests
  final http.Client client;

  /// API base URL
  final String baseUrl;

  /// Creates a new [TransportRemoteDataSourceImpl] instance
  TransportRemoteDataSourceImpl({
    required this.client,
    this.baseUrl = 'https://api.example.com/transport',
  });

  @override
  Future<List<TransportCostModel>> calculateTransportCost(
    String origin,
    String destination,
  ) async {
    // In a real app, this would make an API call
    // For now, we'll return mock data

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Calculate a mock distance based on the origin and destination
    final distance = _calculateMockDistance(origin, destination);

    // Return mock transport costs for different transport types
    return [
      TransportCostModel(
        origin: origin,
        destination: destination,
        distanceInKm: distance,
        transportType: TransportType.car,
        costInEGP: distance * 2.5, // 2.5 EGP per km for car
        durationInMinutes:
            (distance * 0.8).round(), // 0.8 minutes per km for car
      ),
      TransportCostModel(
        origin: origin,
        destination: destination,
        distanceInKm: distance,
        transportType: TransportType.bus,
        costInEGP: distance * 1.2, // 1.2 EGP per km for bus
        durationInMinutes:
            (distance * 1.2).round(), // 1.2 minutes per km for bus
      ),
      TransportCostModel(
        origin: origin,
        destination: destination,
        distanceInKm: distance,
        transportType: TransportType.train,
        costInEGP: distance * 1.5, // 1.5 EGP per km for train
        durationInMinutes:
            (distance * 0.9).round(), // 0.9 minutes per km for train
      ),
      if (distance > 100) // Only show plane for long distances
        TransportCostModel(
          origin: origin,
          destination: destination,
          distanceInKm: distance,
          transportType: TransportType.plane,
          costInEGP: distance * 5.0, // 5.0 EGP per km for plane
          durationInMinutes: (distance * 0.2).round() +
              60, // 0.2 minutes per km for plane + 1 hour for boarding
        ),
      if (_isBoatAvailable(
          origin, destination)) // Only show boat for certain routes
        TransportCostModel(
          origin: origin,
          destination: destination,
          distanceInKm: distance,
          transportType: TransportType.boat,
          costInEGP: distance * 3.0, // 3.0 EGP per km for boat
          durationInMinutes:
              (distance * 1.5).round(), // 1.5 minutes per km for boat
        ),
      if (distance < 10) // Only show walking for short distances
        TransportCostModel(
          origin: origin,
          destination: destination,
          distanceInKm: distance,
          transportType: TransportType.walking,
          costInEGP: 0, // Walking is free
          durationInMinutes:
              (distance * 12).round(), // 12 minutes per km for walking
        ),
    ];
  }

  @override
  Future<List<TransportType>> getAvailableTransportTypes(
    String origin,
    String destination,
  ) async {
    // In a real app, this would make an API call
    // For now, we'll return mock data

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Calculate a mock distance based on the origin and destination
    final distance = _calculateMockDistance(origin, destination);

    // Return available transport types based on distance
    final availableTypes = [
      TransportType.car,
      TransportType.bus,
      TransportType.train,
    ];

    if (distance > 100) {
      availableTypes.add(TransportType.plane);
    }

    if (_isBoatAvailable(origin, destination)) {
      availableTypes.add(TransportType.boat);
    }

    if (distance < 10) {
      availableTypes.add(TransportType.walking);
    }

    return availableTypes;
  }

  @override
  Future<TransportCostModel> getTransportCostByType(
    String origin,
    String destination,
    TransportType transportType,
  ) async {
    // In a real app, this would make an API call
    // For now, we'll return mock data

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Calculate a mock distance based on the origin and destination
    final distance = _calculateMockDistance(origin, destination);

    // Return mock transport cost for the specified type
    switch (transportType) {
      case TransportType.car:
        return TransportCostModel(
          origin: origin,
          destination: destination,
          distanceInKm: distance,
          transportType: TransportType.car,
          costInEGP: distance * 2.5, // 2.5 EGP per km for car
          durationInMinutes:
              (distance * 0.8).round(), // 0.8 minutes per km for car
        );
      case TransportType.bus:
        return TransportCostModel(
          origin: origin,
          destination: destination,
          distanceInKm: distance,
          transportType: TransportType.bus,
          costInEGP: distance * 1.2, // 1.2 EGP per km for bus
          durationInMinutes:
              (distance * 1.2).round(), // 1.2 minutes per km for bus
        );
      case TransportType.train:
        return TransportCostModel(
          origin: origin,
          destination: destination,
          distanceInKm: distance,
          transportType: TransportType.train,
          costInEGP: distance * 1.5, // 1.5 EGP per km for train
          durationInMinutes:
              (distance * 0.9).round(), // 0.9 minutes per km for train
        );
      case TransportType.plane:
        if (distance <= 100) {
          throw ServerException(
              message: 'Plane not available for this distance');
        }
        return TransportCostModel(
          origin: origin,
          destination: destination,
          distanceInKm: distance,
          transportType: TransportType.plane,
          costInEGP: distance * 5.0, // 5.0 EGP per km for plane
          durationInMinutes: (distance * 0.2).round() +
              60, // 0.2 minutes per km for plane + 1 hour for boarding
        );
      case TransportType.boat:
        if (!_isBoatAvailable(origin, destination)) {
          throw ServerException(message: 'Boat not available for this route');
        }
        return TransportCostModel(
          origin: origin,
          destination: destination,
          distanceInKm: distance,
          transportType: TransportType.boat,
          costInEGP: distance * 3.0, // 3.0 EGP per km for boat
          durationInMinutes:
              (distance * 1.5).round(), // 1.5 minutes per km for boat
        );
      case TransportType.walking:
        if (distance >= 10) {
          throw ServerException(
              message: 'Walking not recommended for this distance');
        }
        return TransportCostModel(
          origin: origin,
          destination: destination,
          distanceInKm: distance,
          transportType: TransportType.walking,
          costInEGP: 0, // Walking is free
          durationInMinutes:
              (distance * 12).round(), // 12 minutes per km for walking
        );
    }
  }

  /// Calculate a mock distance between two locations
  double _calculateMockDistance(String origin, String destination) {
    // This is a simple mock distance calculation
    // In a real app, this would use a distance API

    // Map of city coordinates (latitude, longitude)
    final cityCoordinates = {
      'cairo': (30.033333, 31.233334),
      'giza': (29.9773, 31.1325),
      'luxor': (25.6872, 32.6396),
      'aswan': (24.0889, 32.8998),
      'alexandria': (31.2001, 29.9187),
      'sharm el sheikh': (27.9158, 34.3300),
      'hurghada': (27.2579, 33.8116),
    };

    // Default distance if cities are not in our map
    if (!cityCoordinates.containsKey(origin.toLowerCase()) ||
        !cityCoordinates.containsKey(destination.toLowerCase())) {
      return 50.0; // Default 50 km
    }

    // Get coordinates
    final originCoord = cityCoordinates[origin.toLowerCase()]!;
    final destCoord = cityCoordinates[destination.toLowerCase()]!;

    // Calculate distance using Haversine formula (simplified)
    final latDiff = (originCoord.$1 - destCoord.$1).abs();
    final lngDiff = (originCoord.$2 - destCoord.$2).abs();

    // Rough approximation (1 degree is about 111 km)
    return (latDiff * 111 + lngDiff * 111) * 0.7;
  }

  /// Check if boat transport is available for the route
  bool _isBoatAvailable(String origin, String destination) {
    // Boat is only available for routes along the Nile or Mediterranean
    final nileOrMedCities = [
      'cairo',
      'luxor',
      'aswan',
      'alexandria',
      'hurghada',
      'sharm el sheikh',
    ];

    return nileOrMedCities.contains(origin.toLowerCase()) &&
        nileOrMedCities.contains(destination.toLowerCase());
  }
}
