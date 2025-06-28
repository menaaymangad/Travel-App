import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../entities/transport_cost.dart';
import '../repositories/transport_repository.dart';

/// Use case to calculate transport cost between two locations
class CalculateTransportCostUseCase {
  /// Repository instance
  final TransportRepository repository;

  /// Creates a new [CalculateTransportCostUseCase] instance
  CalculateTransportCostUseCase(this.repository);

  /// Execute the use case
  Future<Either<Failure, List<TransportCost>>> call(
      TransportCostParams params) {
    return repository.calculateTransportCost(
      params.origin,
      params.destination,
    );
  }
}

/// Parameters for the [CalculateTransportCostUseCase]
class TransportCostParams extends Equatable {
  /// Origin location name
  final String origin;

  /// Destination location name
  final String destination;

  /// Creates a new [TransportCostParams] instance
  const TransportCostParams({
    required this.origin,
    required this.destination,
  });

  @override
  List<Object?> get props => [origin, destination];
}
