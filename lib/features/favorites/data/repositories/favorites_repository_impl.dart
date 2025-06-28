import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/favorite.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_local_data_source.dart';
import '../models/favorite_model.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource localDataSource;

  FavoritesRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<Favorite>>> getFavorites() async {
    try {
      final models = await localDataSource.getFavorites();
      return Right(models);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load favorites'));
    }
  }

  @override
  Future<Either<Failure, void>> addFavorite(Favorite favorite) async {
    try {
      await localDataSource.addFavorite(FavoriteModel(
        id: favorite.id,
        type: favorite.type,
        name: favorite.name,
        imageUrl: favorite.imageUrl,
      ));
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to add favorite'));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite(String id) async {
    try {
      await localDataSource.removeFavorite(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to remove favorite'));
    }
  }
}
