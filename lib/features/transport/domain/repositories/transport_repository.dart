import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/transport_cost.dart';

/// Repository interface for transport-related operations
abstract class TransportRepository {
  /// Calculate transport cost between two locations
  Future<Either<Failure, List<TransportCost>>> calculateTransportCost(
    String origin,
    String destination,
  );

  /// Get available transport types between two locations
  Future<Either<Failure, List<TransportType>>> getAvailableTransportTypes(
    String origin,
    String destination,
  );

  /// Get transport cost for a specific transport type
  Future<Either<Failure, TransportCost>> getTransportCostByType(
    String origin,
    String destination,
    TransportType transportType,
  );
}
