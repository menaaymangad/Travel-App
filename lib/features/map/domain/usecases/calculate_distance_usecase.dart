import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/error/failures.dart';
import '../entities/distance.dart' as entities;
import '../repositories/distance_repository.dart';

/// Use case to calculate distance between two locations
class CalculateDistanceUseCase {
  /// Repository instance
  final DistanceRepository repository;

  /// Creates a new [CalculateDistanceUseCase] instance
  CalculateDistanceUseCase(this.repository);

  /// Execute the use case
  Future<Either<Failure, entities.Distance>> call(DistanceParams params) {
    return repository.calculateDistance(params.origin, params.destination);
  }
}

/// Parameters for the [CalculateDistanceUseCase]
class DistanceParams extends Equatable {
  /// Origin location
  final LatLng origin;

  /// Destination location
  final LatLng destination;

  /// Creates a new [DistanceParams] instance
  const DistanceParams({
    required this.origin,
    required this.destination,
  });

  @override
  List<Object?> get props => [origin, destination];
}
