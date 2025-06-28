import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/place.dart';
import '../../domain/usecases/filter_places_usecase.dart';
import 'places_state.dart';

/// Cubit for managing places-related state
class PlacesCubit extends Cubit<PlacesState> {
  final FilterPlacesUseCase filterPlacesUseCase;

  /// Creates a new [PlacesCubit] instance
  PlacesCubit({required this.filterPlacesUseCase}) : super(PlacesInitial());

  /// Load places data
  Future<void> loadPlaces() async {
    emit(PlacesLoading());
    try {
      // In a real app, this would fetch data from a repository
      await Future.delayed(const Duration(seconds: 1));
      emit(PlacesFiltered([]));
    } catch (e) {
      emit(PlacesError('Failed to load places: ${e.toString()}'));
    }
  }

  /// Filter places by category
  Future<void> filterPlaces(
      {String? category, String? type, double? minRating}) async {
    emit(PlacesFiltering());
    final result = await filterPlacesUseCase(FilterPlacesParams(
      category: category,
      type: type,
      minRating: minRating,
    ));
    result.fold(
      (failure) => emit(PlacesError(failure.message)),
      (places) => emit(PlacesFiltered(places)),
    );
  }

  /// Search places by query
  void searchPlaces(String query) {
    emit(PlacesSearching());
    try {
      // In a real app, this would search data from a repository
      emit(PlacesSearched(query));
    } catch (e) {
      emit(PlacesError('Failed to search places: ${e.toString()}'));
    }
  }
}
