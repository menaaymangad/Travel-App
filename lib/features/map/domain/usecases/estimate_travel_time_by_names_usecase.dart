import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/travel_time_estimate.dart';
import '../repositories/travel_time_repository.dart';
import 'package:travelapp/features/transport/domain/entities/transport_cost.dart';

/// Use case for estimating travel time between two locations by place names
class EstimateTravelTimeByNamesUseCase
    implements UseCase<TravelTimeEstimate, TravelTimeByNamesParams> {
  /// The travel time repository
  final TravelTimeRepository repository;

  /// Creates a new [EstimateTravelTimeByNamesUseCase] instance
  EstimateTravelTimeByNamesUseCase(this.repository);

  @override
  Future<Either<Failure, TravelTimeEstimate>> call(
      TravelTimeByNamesParams params) {
    return repository.estimateTravelTimeByPlaceNames(
      params.originName,
      params.destinationName,
      params.transportType,
    );
  }
}

/// Parameters for the [EstimateTravelTimeByNamesUseCase]
class TravelTimeByNamesParams extends Equatable {
  /// The origin location name
  final String originName;

  /// The destination location name
  final String destinationName;

  /// The transport type
  final TransportType transportType;

  /// Creates a new [TravelTimeByNamesParams] instance
  const TravelTimeByNamesParams({
    required this.originName,
    required this.destinationName,
    required this.transportType,
  });

  @override
  List<Object?> get props => [originName, destinationName, transportType];
}
