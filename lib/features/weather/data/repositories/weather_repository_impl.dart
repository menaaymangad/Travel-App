import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/weather_forecast.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_local_data_source.dart';
import '../datasources/weather_remote_data_source.dart';

/// Implementation of the weather repository
class WeatherRepositoryImpl implements WeatherRepository {
  /// Remote data source for weather data
  final WeatherRemoteDataSource remoteDataSource;

  /// Local data source for weather data
  final WeatherLocalDataSource localDataSource;

  /// Network info for checking connectivity
  final NetworkInfo networkInfo;

  /// Creates a new [WeatherRepositoryImpl] instance
  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, WeatherForecast>> getWeatherForecast(
      String cityName) async {
    if (await networkInfo.isConnected) {
      try {
        final weatherForecast =
            await remoteDataSource.getWeatherForecast(cityName);
        await localDataSource.cacheWeatherForecast(weatherForecast);
        await localDataSource.saveRecentSearch(cityName);
        return Right(weatherForecast);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localWeatherForecast =
            await localDataSource.getCachedWeatherForecast();
        return Right(localWeatherForecast);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, WeatherForecast>> getWeatherForecastByLocation(
    double latitude,
    double longitude,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final weatherForecast =
            await remoteDataSource.getWeatherForecastByLocation(
          latitude,
          longitude,
        );
        await localDataSource.cacheWeatherForecast(weatherForecast);
        return Right(weatherForecast);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localWeatherForecast =
            await localDataSource.getCachedWeatherForecast();
        return Right(localWeatherForecast);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<String>>> searchCities(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final cities = await remoteDataSource.searchCities(query);
        return Right(cities);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getRecentSearches() async {
    try {
      final recentSearches = await localDataSource.getRecentSearches();
      return Right(recentSearches);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> saveRecentSearch(String cityName) async {
    try {
      final result = await localDataSource.saveRecentSearch(cityName);
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }
}
