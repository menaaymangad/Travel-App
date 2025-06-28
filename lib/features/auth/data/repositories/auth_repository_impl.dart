import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

/// Implementation of [AuthRepository]
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  /// Creates a new [AuthRepositoryImpl] instance
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> signIn({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.signIn(
          email: email,
          password: password,
        );

        await localDataSource.cacheUser(userModel);

        return Right(userModel);
      } on ServerException catch (e) {
        return Left(AuthFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.register(
          name: name,
          email: email,
          password: password,
          phone: phone,
        );

        await localDataSource.cacheUser(userModel);

        return Right(userModel);
      } on ServerException catch (e) {
        return Left(AuthFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      await localDataSource.clearCachedUser();

      return const Right(null);
    } on ServerException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String email,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.resetPassword(email: email);

        return const Right(null);
      } on ServerException catch (e) {
        return Left(AuthFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      // Try to get user from local cache first
      if (await localDataSource.isUserCached()) {
        final userModel = await localDataSource.getCachedUser();
        return Right(userModel);
      }

      // If not cached and network is available, get from remote
      if (await networkInfo.isConnected) {
        final userModel = await remoteDataSource.getCurrentUser();
        await localDataSource.cacheUser(userModel);
        return Right(userModel);
      } else {
        return Left(NetworkFailure(message: 'No internet connection'));
      }
    } on ServerException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure(message: 'Cache error'));
    }
  }

  @override
  Future<Either<Failure, bool>> isSignedIn() async {
    try {
      // Check local cache first
      if (await localDataSource.isUserCached()) {
        return const Right(true);
      }

      // If not cached and network is available, check remote
      if (await networkInfo.isConnected) {
        final isSignedIn = await remoteDataSource.isSignedIn();
        return Right(isSignedIn);
      } else {
        return Left(NetworkFailure(message: 'No internet connection'));
      }
    } on ServerException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure(message: 'Cache error'));
    }
  }
}
