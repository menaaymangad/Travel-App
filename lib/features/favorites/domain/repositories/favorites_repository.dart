import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/favorite.dart';

/// Repository interface for managing favorites
abstract class FavoritesRepository {
  /// Get all favorite items
  Future<Either<Failure, List<Favorite>>> getFavorites();

  /// Add an item to favorites
  Future<Either<Failure, void>> addFavorite(Favorite favorite);

  /// Remove an item from favorites
  Future<Either<Failure, void>> removeFavorite(String id);
}
