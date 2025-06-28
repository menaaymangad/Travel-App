import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/favorite.dart';
import '../repositories/favorites_repository.dart';

/// Use case for adding an item to favorites
class AddFavoriteUseCase implements UseCase<void, Favorite> {
  final FavoritesRepository repository;

  AddFavoriteUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(Favorite favorite) {
    return repository.addFavorite(favorite);
  }
}
