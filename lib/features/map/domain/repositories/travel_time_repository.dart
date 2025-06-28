import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/error/failures.dart';
import '../entities/travel_time_estimate.dart';
import 'package:travelapp/features/transport/domain/entities/transport_cost.dart';

/// Repository interface for travel time estimation
abstract class TravelTimeRepository {
  /// Estimate travel time between two locations
  Future<Either<Failure, TravelTimeEstimate>> estimateTravelTime(
    LatLng origin,
    LatLng destination,
    TransportType transportType,
  );

  /// Estimate travel time between two locations by place names
  Future<Either<Failure, TravelTimeEstimate>> estimateTravelTimeByPlaceNames(
    String originName,
    String destinationName,
    TransportType transportType,
  );

  /// Get current traffic conditions for a route
  Future<Either<Failure, TrafficCondition>> getTrafficCondition(
    LatLng origin,
    LatLng destination,
  );

  /// Get current weather conditions for a location
  Future<Either<Failure, WeatherCondition>> getWeatherCondition(
    LatLng location,
  );
}
