import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import '../../domain/entities/travel_time_estimate.dart';
import '../../domain/usecases/estimate_travel_time_by_names_usecase.dart';
import '../../domain/usecases/estimate_travel_time_usecase.dart';
import 'package:travelapp/features/transport/domain/entities/transport_cost.dart';
import 'travel_time_state.dart';

/// Cubit for managing travel time-related state
class TravelTimeCubit extends Cubit<TravelTimeState> {
  /// Use case for estimating travel time between coordinates
  final EstimateTravelTimeUseCase estimateTravelTimeUseCase;

  /// Use case for estimating travel time between place names
  final EstimateTravelTimeByNamesUseCase estimateTravelTimeByNamesUseCase;

  /// Creates a new [TravelTimeCubit] instance
  TravelTimeCubit({
    required this.estimateTravelTimeUseCase,
    required this.estimateTravelTimeByNamesUseCase,
  }) : super(TravelTimeInitial());

  /// Estimate travel time between two locations
  Future<void> estimateTravelTime(
    LatLng origin,
    LatLng destination,
    TransportType transportType,
  ) async {
    emit(TravelTimeLoading());

    final params = TravelTimeParams(
      origin: origin,
      destination: destination,
      transportType: transportType,
    );

    final result = await estimateTravelTimeUseCase(params);

    result.fold(
      (failure) => emit(TravelTimeError(failure.message)),
      (travelTimeEstimate) => emit(TravelTimeLoaded(travelTimeEstimate)),
    );
  }

  /// Estimate travel time between two locations by place names
  Future<void> estimateTravelTimeByNames(
    String originName,
    String destinationName,
    TransportType transportType,
  ) async {
    emit(TravelTimeLoading());

    final params = TravelTimeByNamesParams(
      originName: originName,
      destinationName: destinationName,
      transportType: transportType,
    );

    final result = await estimateTravelTimeByNamesUseCase(params);

    result.fold(
      (failure) => emit(TravelTimeError(failure.message)),
      (travelTimeEstimate) => emit(TravelTimeLoaded(travelTimeEstimate)),
    );
  }

  /// Estimate travel time for all available transport types
  Future<void> estimateAllTravelTimes(
    String originName,
    String destinationName,
  ) async {
    emit(TravelTimeLoading());

    // List of transport types to check
    final transportTypes = [
      TransportType.car,
      TransportType.bus,
      TransportType.train,
      TransportType.plane,
      TransportType.boat,
      TransportType.walking,
    ];

    final Map<TransportType, TravelTimeEstimate> travelTimeEstimates = {};

    // Estimate travel time for each transport type
    for (final transportType in transportTypes) {
      final params = TravelTimeByNamesParams(
        originName: originName,
        destinationName: destinationName,
        transportType: transportType,
      );

      final result = await estimateTravelTimeByNamesUseCase(params);

      result.fold(
        (failure) {
          // Skip this transport type if there's an error
          // This could happen if the transport type is not available for the route
        },
        (travelTimeEstimate) {
          travelTimeEstimates[transportType] = travelTimeEstimate;
        },
      );
    }

    if (travelTimeEstimates.isEmpty) {
      emit(const TravelTimeError('No travel time estimates available'));
    } else {
      emit(TravelTimeMultiLoaded(
        travelTimeEstimates: travelTimeEstimates,
        origin: originName,
        destination: destinationName,
      ));
    }
  }
}
