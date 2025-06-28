import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/distance.dart' as entities;
import 'package:latlong2/latlong.dart';

/// Repository interface for distance calculations
abstract class DistanceRepository {
  /// Calculate distance between two locations
  Future<Either<Failure, entities.Distance>> calculateDistance(
      LatLng origin, LatLng destination);

  /// Calculate distance between two locations by place names
  Future<Either<Failure, entities.Distance>> calculateDistanceByPlaceNames(
      String originName, String destinationName);
}
