import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp/core/usecases/usecase.dart';
import '../../domain/usecases/get_trip_suggestions_usecase.dart';
import 'trip_suggestions_state.dart';

class TripSuggestionsCubit extends Cubit<TripSuggestionsState> {
  final GetTripSuggestionsUseCase getTripSuggestionsUseCase;
  TripSuggestionsCubit({required this.getTripSuggestionsUseCase})
      : super(TripSuggestionsInitial());

  Future<void> loadSuggestions() async {
    emit(TripSuggestionsLoading());
    final result = await getTripSuggestionsUseCase(NoParams());
    result.fold(
      (failure) => emit(TripSuggestionsError(failure.message)),
      (suggestions) => emit(TripSuggestionsLoaded(suggestions)),
    );
  }
}
