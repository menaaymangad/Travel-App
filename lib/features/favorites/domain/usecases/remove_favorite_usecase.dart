import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/favorites_repository.dart';

/// Use case for removing an item from favorites
class RemoveFavoriteUseCase implements UseCase<void, String> {
  final FavoritesRepository repository;

  RemoveFavoriteUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) {
    return repository.removeFavorite(id);
  }
}
