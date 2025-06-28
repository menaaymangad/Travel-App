import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/transport_cost.dart';
import '../../domain/repositories/transport_repository.dart';
import '../datasources/transport_local_data_source.dart';
import '../datasources/transport_remote_data_source.dart';

/// Implementation of the transport repository
class TransportRepositoryImpl implements TransportRepository {
  /// Remote data source for transport costs
  final TransportRemoteDataSource remoteDataSource;

  /// Local data source for caching transport costs
  final TransportLocalDataSource localDataSource;

  /// Network info for checking connectivity
  final NetworkInfo networkInfo;

  /// Creates a new [TransportRepositoryImpl] instance
  TransportRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<TransportCost>>> calculateTransportCost(
    String origin,
    String destination,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCosts = await remoteDataSource.calculateTransportCost(
          origin,
          destination,
        );

        // Cache the results
        await localDataSource.cacheTransportCosts(
          origin,
          destination,
          remoteCosts,
        );

        return Right(remoteCosts);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      // Try to get cached data if offline
      try {
        final localCosts = await localDataSource.getCachedTransportCosts(
          origin,
          destination,
        );
        return Right(localCosts);
      } on CacheException {
        return const Left(CacheFailure(message: 'No cached data available'));
      }
    }
  }

  @override
  Future<Either<Failure, List<TransportType>>> getAvailableTransportTypes(
    String origin,
    String destination,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final transportTypes =
            await remoteDataSource.getAvailableTransportTypes(
          origin,
          destination,
        );
        return Right(transportTypes);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      // For simplicity, return a default list of transport types when offline
      return const Right([
        TransportType.car,
        TransportType.bus,
        TransportType.train,
      ]);
    }
  }

  @override
  Future<Either<Failure, TransportCost>> getTransportCostByType(
    String origin,
    String destination,
    TransportType transportType,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCost = await remoteDataSource.getTransportCostByType(
          origin,
          destination,
          transportType,
        );

        // Cache the result
        await localDataSource.cacheTransportCostByType(
          origin,
          destination,
          transportType,
          remoteCost,
        );

        return Right(remoteCost);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      // Try to get cached data if offline
      try {
        final localCost = await localDataSource.getCachedTransportCostByType(
          origin,
          destination,
          transportType,
        );
        return Right(localCost);
      } on CacheException {
        return const Left(CacheFailure(message: 'No cached data available'));
      }
    }
  }
}
