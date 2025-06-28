import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/travel_time_estimate.dart';
import '../repositories/travel_time_repository.dart';
import 'package:travelapp/features/transport/domain/entities/transport_cost.dart';

/// Use case for estimating travel time between two locations
class EstimateTravelTimeUseCase
    implements UseCase<TravelTimeEstimate, TravelTimeParams> {
  /// The travel time repository
  final TravelTimeRepository repository;

  /// Creates a new [EstimateTravelTimeUseCase] instance
  EstimateTravelTimeUseCase(this.repository);

  @override
  Future<Either<Failure, TravelTimeEstimate>> call(TravelTimeParams params) {
    return repository.estimateTravelTime(
      params.origin,
      params.destination,
      params.transportType,
    );
  }
}

/// Parameters for the [EstimateTravelTimeUseCase]
class TravelTimeParams extends Equatable {
  /// The origin location
  final LatLng origin;

  /// The destination location
  final LatLng destination;

  /// The transport type
  final TransportType transportType;

  /// Creates a new [TravelTimeParams] instance
  const TravelTimeParams({
    required this.origin,
    required this.destination,
    required this.transportType,
  });

  @override
  List<Object?> get props => [origin, destination, transportType];
}
