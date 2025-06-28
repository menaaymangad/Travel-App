import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/landmark.dart';
import '../../domain/repositories/landmark_repository.dart';
import '../datasources/landmark_local_data_source.dart';
import '../datasources/landmark_remote_data_source.dart';

/// Implementation of the [LandmarkRepository]
class LandmarkRepositoryImpl implements LandmarkRepository {
  /// Remote data source
  final LandmarkRemoteDataSource remoteDataSource;

  /// Local data source
  final LandmarkLocalDataSource localDataSource;

  /// Network info
  final NetworkInfo networkInfo;

  /// Creates a new [LandmarkRepositoryImpl] instance
  LandmarkRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Landmark>>> getLandmarks() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteLandmarks = await remoteDataSource.getLandmarks();
        localDataSource.cacheLandmarks(remoteLandmarks);
        return Right(remoteLandmarks);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localLandmarks = await localDataSource.getCachedLandmarks();
        return Right(localLandmarks);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Landmark>> getLandmarkById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteLandmark = await remoteDataSource.getLandmarkById(id);
        localDataSource.cacheLandmark(remoteLandmark);
        return Right(remoteLandmark);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localLandmark = await localDataSource.getCachedLandmarkById(id);
        return Right(localLandmark);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Landmark>>> getLandmarksByCity(
      String city) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteLandmarks = await remoteDataSource.getLandmarksByCity(city);
        return Right(remoteLandmarks);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Landmark>>> getLandmarksByTags(
      List<String> tags) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteLandmarks = await remoteDataSource.getLandmarksByTags(tags);
        return Right(remoteLandmarks);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Landmark>>> searchLandmarks(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteLandmarks = await remoteDataSource.searchLandmarks(query);
        return Right(remoteLandmarks);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure(message: 'No internet connection'));
    }
  }
}
