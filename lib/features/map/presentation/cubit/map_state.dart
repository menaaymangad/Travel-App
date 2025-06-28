import 'package:equatable/equatable.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../domain/entities/distance.dart' as entities;
import '../../domain/entities/travel_time_estimate.dart';
import 'package:travelapp/features/transport/domain/entities/transport_cost.dart';

/// Base state for map-related states
abstract class MapState extends Equatable {
  /// Creates a new [MapState] instance
  const MapState();

  @override
  List<Object?> get props => [];
}

/// Initial state for the map
class MapInitial extends MapState {}

/// State when the map markers have been updated
class MapMarkersUpdated extends MapState {
  /// The updated set of markers
  final Set<Marker> markers;

  /// Creates a new [MapMarkersUpdated] instance
  const MapMarkersUpdated(this.markers);

  @override
  List<Object?> get props => [markers];
}

/// State when a location has been selected on the map
class MapLocationSelected extends MapState {
  /// The selected location
  final LatLng location;

  /// Creates a new [MapLocationSelected] instance
  const MapLocationSelected(this.location);

  @override
  List<Object?> get props => [location];
}

/// State when the password visibility has changed
class MapPasswordVisibilityChanged extends MapState {}

/// State when the map is loading
class MapLoading extends MapState {}

/// State when the map has loaded
class MapLoaded extends MapState {}

/// State when an error occurs
class MapError extends MapState {
  /// The error message
  final String message;

  /// Creates a new [MapError] instance
  const MapError(this.message);

  @override
  List<Object?> get props => [message];
}

/// State when distance calculation is loading
class DistanceCalculationLoading extends MapState {}

/// State when distance calculation is complete
class DistanceCalculationLoaded extends MapState {
  /// The calculated distance
  final entities.Distance distance;

  /// Creates a new [DistanceCalculationLoaded] instance
  const DistanceCalculationLoaded(this.distance);

  @override
  List<Object?> get props => [distance];
}

/// State when distance calculation fails
class DistanceCalculationError extends MapState {
  /// The error message
  final String message;

  /// Creates a new [DistanceCalculationError] instance
  const DistanceCalculationError(this.message);

  @override
  List<Object?> get props => [message];
}

/// State when travel time estimation is loading
class TravelTimeEstimationLoading extends MapState {}

/// State when travel time estimation is complete
class TravelTimeEstimationLoaded extends MapState {
  /// The estimated travel time
  final TravelTimeEstimate travelTimeEstimate;

  /// Creates a new [TravelTimeEstimationLoaded] instance
  const TravelTimeEstimationLoaded(this.travelTimeEstimate);

  @override
  List<Object?> get props => [travelTimeEstimate];
}

/// State when multiple travel time estimations are loaded
class TravelTimeMultiEstimationLoaded extends MapState {
  /// The loaded travel time estimates for different transport types
  final Map<TransportType, TravelTimeEstimate> travelTimeEstimates;

  /// The origin location name
  final String origin;

  /// The destination location name
  final String destination;

  /// Creates a new [TravelTimeMultiEstimationLoaded] instance
  const TravelTimeMultiEstimationLoaded({
    required this.travelTimeEstimates,
    required this.origin,
    required this.destination,
  });

  @override
  List<Object?> get props => [travelTimeEstimates, origin, destination];
}

/// State when travel time estimation fails
class TravelTimeEstimationError extends MapState {
  /// The error message
  final String message;

  /// Creates a new [TravelTimeEstimationError] instance
  const TravelTimeEstimationError(this.message);

  @override
  List<Object?> get props => [message];
}
