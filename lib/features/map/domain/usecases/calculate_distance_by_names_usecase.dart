import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:travelapp/features/map/domain/entities/distance.dart' as entity;
import '../../../../core/error/failures.dart';
import '../repositories/distance_repository.dart';

/// Use case to calculate distance between two locations by their names
class CalculateDistanceByNamesUseCase {
  /// Repository instance
  final DistanceRepository repository;

  /// Creates a new [CalculateDistanceByNamesUseCase] instance
  CalculateDistanceByNamesUseCase(this.repository);

  /// Execute the use case
  Future<Either<Failure, entity.Distance>> call(DistanceByNamesParams params) {
    return repository.calculateDistanceByPlaceNames(
      params.originName,
      params.destinationName,
    );
  }
}

/// Parameters for the [CalculateDistanceByNamesUseCase]
class DistanceByNamesParams extends Equatable {
  /// Origin place name
  final String originName;

  /// Destination place name
  final String destinationName;

  /// Creates a new [DistanceByNamesParams] instance
  const DistanceByNamesParams({
    required this.originName,
    required this.destinationName,
  });

  @override
  List<Object?> get props => [originName, destinationName];
}
