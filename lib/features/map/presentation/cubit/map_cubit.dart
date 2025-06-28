import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../domain/entities/distance.dart' as entities;
import '../../domain/entities/travel_time_estimate.dart';
import '../../domain/usecases/calculate_distance_by_names_usecase.dart';
import '../../domain/usecases/calculate_distance_usecase.dart';
import '../../domain/usecases/estimate_travel_time_by_names_usecase.dart';
import '../../domain/usecases/estimate_travel_time_usecase.dart';
import 'map_state.dart';

/// Cubit for managing map-related state
class MapCubit extends Cubit<MapState> {
  /// Use case for calculating distance between coordinates
  final CalculateDistanceUseCase? calculateDistanceUseCase;

  /// Use case for calculating distance between place names
  final CalculateDistanceByNamesUseCase? calculateDistanceByNamesUseCase;

  /// Use case for estimating travel time between coordinates
  final EstimateTravelTimeUseCase? estimateTravelTimeUseCase;

  /// Use case for estimating travel time between place names
  final EstimateTravelTimeByNamesUseCase? estimateTravelTimeByNamesUseCase;

  /// Creates a new [MapCubit] instance
  MapCubit({
    this.calculateDistanceUseCase,
    this.calculateDistanceByNamesUseCase,
    this.estimateTravelTimeUseCase,
    this.estimateTravelTimeByNamesUseCase,
  }) : super(MapInitial());

  /// Current selected location
  LatLng? selectedLocation;

  /// Set of markers on the map
  Set<Marker> markers = {};

  /// Current calculated route
  entities.Distance? calculatedDistance;

  /// Current travel time estimate
  TravelTimeEstimate? travelTimeEstimate;

  /// Polylines for the map
  List<Polyline> polylines = [];

  /// Icon for showing password visibility
  Icon suffix = const Icon(Icons.visibility_outlined);

  /// Whether the password is visible
  bool isPasswordVisible = false;

  /// Toggle password visibility
  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    suffix = isPasswordVisible
        ? const Icon(Icons.visibility_outlined)
        : const Icon(Icons.visibility_off_outlined);
    emit(MapPasswordVisibilityChanged());
  }

  /// Add a marker to the map
  void addMarker(LatLng position, String id, String title, String snippet) {
    final marker = Marker(
      point: position,
      width: 40,
      height: 40,
      child: Icon(Icons.location_on, color: Colors.red),
    );
    markers.add(marker);
    emit(MapMarkersUpdated(markers));
  }

  /// Clear all markers from the map
  void clearMarkers() {
    markers = {};
    emit(MapMarkersUpdated(markers));
  }

  /// Set the selected location
  void selectLocation(LatLng location) {
    selectedLocation = location;
    emit(MapLocationSelected(location));
  }

  /// Calculate distance between two coordinates
  Future<void> calculateDistance(LatLng origin, LatLng destination) async {
    if (calculateDistanceUseCase == null) {
      emit(
          const DistanceCalculationError('Distance calculation not available'));
      return;
    }

    emit(DistanceCalculationLoading());

    final params = DistanceParams(
      origin: origin,
      destination: destination,
    );

    final result = await calculateDistanceUseCase!(params);

    result.fold(
      (failure) => emit(DistanceCalculationError(failure.message)),
      (distance) {
        calculatedDistance = distance;
        _updatePolylines(distance);
        emit(DistanceCalculationLoaded(distance));
      },
    );
  }

  /// Calculate distance between two place names
  Future<void> calculateDistanceByNames(
      String originName, String destinationName) async {
    if (calculateDistanceByNamesUseCase == null) {
      emit(
          const DistanceCalculationError('Distance calculation not available'));
      return;
    }

    emit(DistanceCalculationLoading());

    final params = DistanceByNamesParams(
      originName: originName,
      destinationName: destinationName,
    );

    final result = await calculateDistanceByNamesUseCase!(params);

    result.fold(
      (failure) => emit(DistanceCalculationError(failure.message)),
      (distance) {
        calculatedDistance = distance as entities.Distance?;
        _updatePolylines(distance);
        emit(DistanceCalculationLoaded(distance));
      },
    );
  }

  /// Update polylines on the map based on calculated distance
  void _updatePolylines(entities.Distance distance) {
    final polyline = Polyline(
      points: distance.polylinePoints,
      color: Colors.blue,
      strokeWidth: 5,
    );

    polylines = [polyline];
  }

  /// Get the current polylines
  List<Polyline> get currentPolylines => polylines;
}
