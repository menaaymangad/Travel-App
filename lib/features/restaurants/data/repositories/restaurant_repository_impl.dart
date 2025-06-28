import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../datasources/restaurant_local_data_source.dart';
import '../datasources/restaurant_remote_data_source.dart';

/// Implementation of the [RestaurantRepository]
class RestaurantRepositoryImpl implements RestaurantRepository {
  /// Remote data source
  final RestaurantRemoteDataSource remoteDataSource;

  /// Local data source
  final RestaurantLocalDataSource localDataSource;

  /// Network info
  final NetworkInfo networkInfo;

  /// Creates a new [RestaurantRepositoryImpl] instance
  RestaurantRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Restaurant>>> getRestaurants() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRestaurants = await remoteDataSource.getRestaurants();
        localDataSource.cacheRestaurants(remoteRestaurants);
        return Right(remoteRestaurants);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localRestaurants = await localDataSource.getCachedRestaurants();
        return Right(localRestaurants);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Restaurant>> getRestaurantById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRestaurant = await remoteDataSource.getRestaurantById(id);
        localDataSource.cacheRestaurant(remoteRestaurant);
        return Right(remoteRestaurant);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localRestaurant =
            await localDataSource.getCachedRestaurantById(id);
        return Right(localRestaurant);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Restaurant>>> getRestaurantsByCity(
      String city) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRestaurants =
            await remoteDataSource.getRestaurantsByCity(city);
        return Right(remoteRestaurants);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localRestaurants =
            await localDataSource.getCachedRestaurantsByCity(city);
        return Right(localRestaurants);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Restaurant>>> getRestaurantsByCuisine(
      String cuisineType) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRestaurants =
            await remoteDataSource.getRestaurantsByCuisine(cuisineType);
        return Right(remoteRestaurants);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localRestaurants =
            await localDataSource.getCachedRestaurantsByCuisine(cuisineType);
        return Right(localRestaurants);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Restaurant>>> getRestaurantsByPriceRange(
      double minPrice, double maxPrice) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRestaurants = await remoteDataSource
            .getRestaurantsByPriceRange(minPrice, maxPrice);
        return Right(remoteRestaurants);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localRestaurants = await localDataSource
            .getCachedRestaurantsByPriceRange(minPrice, maxPrice);
        return Right(localRestaurants);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Restaurant>>> searchRestaurants(
      String query) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRestaurants =
            await remoteDataSource.searchRestaurants(query);
        return Right(remoteRestaurants);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure(message: 'No internet connection'));
    }
  }
}
