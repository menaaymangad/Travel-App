import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/travel_time_estimate.dart';
import '../../domain/repositories/travel_time_repository.dart';
import '../datasources/travel_time_remote_data_source.dart';
import 'package:travelapp/features/transport/domain/entities/transport_cost.dart';

/// Implementation of the travel time repository
class TravelTimeRepositoryImpl implements TravelTimeRepository {
  /// Remote data source for travel time estimates
  final TravelTimeRemoteDataSource remoteDataSource;

  /// Network info for checking connectivity
  final NetworkInfo networkInfo;

  /// Creates a new [TravelTimeRepositoryImpl] instance
  TravelTimeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, TravelTimeEstimate>> estimateTravelTime(
    LatLng origin,
    LatLng destination,
    TransportType transportType,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final travelTimeEstimate = await remoteDataSource.estimateTravelTime(
          origin,
          destination,
          transportType,
        );
        return Right(travelTimeEstimate);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, TravelTimeEstimate>> estimateTravelTimeByPlaceNames(
    String originName,
    String destinationName,
    TransportType transportType,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final travelTimeEstimate =
            await remoteDataSource.estimateTravelTimeByPlaceNames(
          originName,
          destinationName,
          transportType,
        );
        return Right(travelTimeEstimate);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, TrafficCondition>> getTrafficCondition(
    LatLng origin,
    LatLng destination,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final trafficCondition = await remoteDataSource.getTrafficCondition(
          origin,
          destination,
        );
        return Right(trafficCondition);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, WeatherCondition>> getWeatherCondition(
    LatLng location,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final weatherCondition = await remoteDataSource.getWeatherCondition(
          location,
        );
        return Right(weatherCondition);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }
  }
}
