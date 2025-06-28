import 'package:equatable/equatable.dart';
import '../../domain/entities/travel_time_estimate.dart';
import 'package:travelapp/features/transport/domain/entities/transport_cost.dart';

/// Base state for travel time-related states
abstract class TravelTimeState extends Equatable {
  /// Creates a new [TravelTimeState] instance
  const TravelTimeState();

  @override
  List<Object?> get props => [];
}

/// Initial state for travel time
class TravelTimeInitial extends TravelTimeState {}

/// State when travel time data is loading
class TravelTimeLoading extends TravelTimeState {}

/// State when travel time estimation has been loaded
class TravelTimeLoaded extends TravelTimeState {
  /// The loaded travel time estimate
  final TravelTimeEstimate travelTimeEstimate;

  /// Creates a new [TravelTimeLoaded] instance
  const TravelTimeLoaded(this.travelTimeEstimate);

  @override
  List<Object?> get props => [travelTimeEstimate];
}

/// State when travel time estimation for multiple transport types has been loaded
class TravelTimeMultiLoaded extends TravelTimeState {
  /// The loaded travel time estimates for different transport types
  final Map<TransportType, TravelTimeEstimate> travelTimeEstimates;

  /// The origin location name
  final String origin;

  /// The destination location name
  final String destination;

  /// Creates a new [TravelTimeMultiLoaded] instance
  const TravelTimeMultiLoaded({
    required this.travelTimeEstimates,
    required this.origin,
    required this.destination,
  });

  @override
  List<Object?> get props => [travelTimeEstimates, origin, destination];
}

/// State when traffic condition has been loaded
class TrafficConditionLoaded extends TravelTimeState {
  /// The loaded traffic condition
  final TrafficCondition trafficCondition;

  /// Creates a new [TrafficConditionLoaded] instance
  const TrafficConditionLoaded(this.trafficCondition);

  @override
  List<Object?> get props => [trafficCondition];
}

/// State when weather condition has been loaded
class WeatherConditionLoaded extends TravelTimeState {
  /// The loaded weather condition
  final WeatherCondition weatherCondition;

  /// Creates a new [WeatherConditionLoaded] instance
  const WeatherConditionLoaded(this.weatherCondition);

  @override
  List<Object?> get props => [weatherCondition];
}

/// State when an error occurs
class TravelTimeError extends TravelTimeState {
  /// The error message
  final String message;

  /// Creates a new [TravelTimeError] instance
  const TravelTimeError(this.message);

  @override
  List<Object?> get props => [message];
}
