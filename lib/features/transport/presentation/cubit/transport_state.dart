import 'package:equatable/equatable.dart';
import '../../domain/entities/transport_cost.dart';

/// Base state for transport-related states
abstract class TransportState extends Equatable {
  /// Creates a new [TransportState] instance
  const TransportState();

  @override
  List<Object?> get props => [];
}

/// Initial state for transport
class TransportInitial extends TransportState {}

/// State when transport data is loading
class TransportLoading extends TransportState {}

/// State when transport costs have been loaded
class TransportCostsLoaded extends TransportState {
  /// The loaded transport costs
  final List<TransportCost> transportCosts;

  /// The origin location
  final String origin;

  /// The destination location
  final String destination;

  /// Creates a new [TransportCostsLoaded] instance
  const TransportCostsLoaded({
    required this.transportCosts,
    required this.origin,
    required this.destination,
  });

  @override
  List<Object?> get props => [transportCosts, origin, destination];
}

/// State when a specific transport cost has been loaded
class TransportCostByTypeLoaded extends TransportState {
  /// The loaded transport cost
  final TransportCost transportCost;

  /// Creates a new [TransportCostByTypeLoaded] instance
  const TransportCostByTypeLoaded(this.transportCost);

  @override
  List<Object?> get props => [transportCost];
}

/// State when available transport types have been loaded
class TransportTypesLoaded extends TransportState {
  /// The loaded transport types
  final List<TransportType> transportTypes;

  /// The origin location
  final String origin;

  /// The destination location
  final String destination;

  /// Creates a new [TransportTypesLoaded] instance
  const TransportTypesLoaded({
    required this.transportTypes,
    required this.origin,
    required this.destination,
  });

  @override
  List<Object?> get props => [transportTypes, origin, destination];
}

/// State when an error occurs
class TransportError extends TransportState {
  /// The error message
  final String message;

  /// Creates a new [TransportError] instance
  const TransportError(this.message);

  @override
  List<Object?> get props => [message];
}
