import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import 'package:travelapp/features/map/domain/entities/distance.dart'
    as entities;
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/repositories/distance_repository.dart';
import '../datasources/distance_remote_data_source.dart';

/// Implementation of the distance repository
class DistanceRepositoryImpl implements DistanceRepository {
  /// Remote data source for distance calculations
  final DistanceRemoteDataSource remoteDataSource;

  /// Network info for checking connectivity
  final NetworkInfo networkInfo;

  /// Creates a new [DistanceRepositoryImpl] instance
  DistanceRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, entities.Distance>> calculateDistance(
    LatLng origin,
    LatLng destination,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final distanceValue = await remoteDataSource.calculateDistance(
          LatLng(origin.latitude, origin.longitude),
          LatLng(destination.latitude, destination.longitude),
        );
        return Right(entities.Distance(
          origin: LatLng(origin.latitude, origin.longitude),
          destination: LatLng(destination.latitude, destination.longitude),
          distanceInMeters: distanceValue * 1000, // Convert km to meters
          distanceText: '${distanceValue.toStringAsFixed(1)} km',
          durationInSeconds: 0, // TODO: Get from API
          durationText: 'Unknown', // TODO: Get from API
          polylinePoints: [], // TODO: Get from API
        ));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, entities.Distance>> calculateDistanceByPlaceNames(
    String originName,
    String destinationName,
  ) async {
    // TODO: Implement this method or remove from interface
    return const Left(ServerFailure(message: 'Method not implemented'));
  }
}
