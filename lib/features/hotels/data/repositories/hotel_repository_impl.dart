import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/hotel.dart';
import '../../domain/repositories/hotel_repository.dart';
import '../datasources/hotel_local_data_source.dart';
import '../datasources/hotel_remote_data_source.dart';

/// Implementation of the [HotelRepository]
class HotelRepositoryImpl implements HotelRepository {
  /// Remote data source
  final HotelRemoteDataSource remoteDataSource;

  /// Local data source
  final HotelLocalDataSource localDataSource;

  /// Network info
  final NetworkInfo networkInfo;

  /// Creates a new [HotelRepositoryImpl] instance
  HotelRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Hotel>>> getHotels() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteHotels = await remoteDataSource.getHotels();
        localDataSource.cacheHotels(remoteHotels);
        return Right(remoteHotels);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localHotels = await localDataSource.getCachedHotels();
        return Right(localHotels);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Hotel>> getHotelById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteHotel = await remoteDataSource.getHotelById(id);
        localDataSource.cacheHotel(remoteHotel);
        return Right(remoteHotel);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localHotel = await localDataSource.getCachedHotelById(id);
        return Right(localHotel);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Hotel>>> getHotelsByCity(String city) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteHotels = await remoteDataSource.getHotelsByCity(city);
        return Right(remoteHotels);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localHotels = await localDataSource.getCachedHotelsByCity(city);
        return Right(localHotels);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Hotel>>> getHotelsByStars(int stars) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteHotels = await remoteDataSource.getHotelsByStars(stars);
        return Right(remoteHotels);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localHotels = await localDataSource.getCachedHotelsByStars(stars);
        return Right(localHotels);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Hotel>>> getHotelsByPriceRange(
      double minPrice, double maxPrice) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteHotels =
            await remoteDataSource.getHotelsByPriceRange(minPrice, maxPrice);
        return Right(remoteHotels);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localHotels = await localDataSource.getCachedHotelsByPriceRange(
            minPrice, maxPrice);
        return Right(localHotels);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Hotel>>> searchHotels(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteHotels = await remoteDataSource.searchHotels(query);
        return Right(remoteHotels);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure(message: 'No internet connection'));
    }
  }
}
