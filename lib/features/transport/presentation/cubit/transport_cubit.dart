import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/transport_cost.dart';
import '../../domain/usecases/calculate_transport_cost_usecase.dart';
import '../../domain/usecases/get_transport_cost_by_type_usecase.dart';
import 'transport_state.dart';

/// Cubit for managing transport-related state
class TransportCubit extends Cubit<TransportState> {
  /// Use case for calculating transport costs
  final CalculateTransportCostUseCase calculateTransportCostUseCase;

  /// Use case for getting transport cost by type
  final GetTransportCostByTypeUseCase getTransportCostByTypeUseCase;

  /// Creates a new [TransportCubit] instance
  TransportCubit({
    required this.calculateTransportCostUseCase,
    required this.getTransportCostByTypeUseCase,
  }) : super(TransportInitial());

  /// Calculate transport costs between two locations
  Future<void> calculateTransportCosts(
      String origin, String destination) async {
    emit(TransportLoading());

    final params = TransportCostParams(
      origin: origin,
      destination: destination,
    );

    final result = await calculateTransportCostUseCase(params);

    result.fold(
      (failure) => emit(TransportError(failure.message)),
      (transportCosts) => emit(TransportCostsLoaded(
        transportCosts: transportCosts,
        origin: origin,
        destination: destination,
      )),
    );
  }

  /// Get transport cost for a specific transport type
  Future<void> getTransportCostByType(
    String origin,
    String destination,
    TransportType transportType,
  ) async {
    emit(TransportLoading());

    final params = TransportCostByTypeParams(
      origin: origin,
      destination: destination,
      transportType: transportType,
    );

    final result = await getTransportCostByTypeUseCase(params);

    result.fold(
      (failure) => emit(TransportError(failure.message)),
      (transportCost) => emit(TransportCostByTypeLoaded(transportCost)),
    );
  }

  /// Get available transport types between two locations
  Future<void> getAvailableTransportTypes(
      String origin, String destination) async {
    emit(TransportLoading());

    // For now, we'll use a simplified approach
    // In a real app, this would use a dedicated use case
    final params = TransportCostParams(
      origin: origin,
      destination: destination,
    );

    final result = await calculateTransportCostUseCase(params);

    result.fold(
      (failure) => emit(TransportError(failure.message)),
      (transportCosts) {
        final transportTypes =
            transportCosts.map((cost) => cost.transportType).toSet().toList();

        emit(TransportTypesLoaded(
          transportTypes: transportTypes,
          origin: origin,
          destination: destination,
        ));
      },
    );
  }
}
