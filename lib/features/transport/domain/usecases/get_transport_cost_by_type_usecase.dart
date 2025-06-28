import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../entities/transport_cost.dart';
import '../repositories/transport_repository.dart';

/// Use case to get transport cost for a specific transport type
class GetTransportCostByTypeUseCase {
  /// Repository instance
  final TransportRepository repository;

  /// Creates a new [GetTransportCostByTypeUseCase] instance
  GetTransportCostByTypeUseCase(this.repository);

  /// Execute the use case
  Future<Either<Failure, TransportCost>> call(
      TransportCostByTypeParams params) {
    return repository.getTransportCostByType(
      params.origin,
      params.destination,
      params.transportType,
    );
  }
}

/// Parameters for the [GetTransportCostByTypeUseCase]
class TransportCostByTypeParams extends Equatable {
  /// Origin location name
  final String origin;

  /// Destination location name
  final String destination;

  /// Type of transport
  final TransportType transportType;

  /// Creates a new [TransportCostByTypeParams] instance
  const TransportCostByTypeParams({
    required this.origin,
    required this.destination,
    required this.transportType,
  });

  @override
  List<Object?> get props => [origin, destination, transportType];
}
