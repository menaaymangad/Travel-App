import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp/core/usecases/usecase.dart';
import '../../domain/entities/favorite.dart';
import '../../domain/usecases/add_favorite_usecase.dart';
import '../../domain/usecases/remove_favorite_usecase.dart';
import '../../domain/usecases/get_favorites_usecase.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final GetFavoritesUseCase getFavoritesUseCase;
  final AddFavoriteUseCase addFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;

  FavoritesCubit({
    required this.getFavoritesUseCase,
    required this.addFavoriteUseCase,
    required this.removeFavoriteUseCase,
  }) : super(FavoritesInitial());

  Future<void> loadFavorites() async {
    emit(FavoritesLoading());
    final result = await getFavoritesUseCase(NoParams());
    result.fold(
      (failure) => emit(FavoritesError(failure.message)),
      (favorites) => emit(FavoritesLoaded(favorites)),
    );
  }

  Future<void> addFavorite(Favorite favorite) async {
    final result = await addFavoriteUseCase(favorite);
    result.fold(
      (failure) => emit(FavoritesError(failure.message)),
      (_) => loadFavorites(),
    );
  }

  Future<void> removeFavorite(String id) async {
    final result = await removeFavoriteUseCase(id);
    result.fold(
      (failure) => emit(FavoritesError(failure.message)),
      (_) => loadFavorites(),
    );
  }
}
