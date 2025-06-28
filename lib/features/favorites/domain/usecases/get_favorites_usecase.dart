import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/favorite.dart';
import '../repositories/favorites_repository.dart';

/// Use case for getting all favorite items
class GetFavoritesUseCase implements UseCase<List<Favorite>, NoParams> {
  final FavoritesRepository repository;

  GetFavoritesUseCase(this.repository);

  @override
  Future<Either<Failure, List<Favorite>>> call(NoParams params) {
    return repository.getFavorites();
  }
}
