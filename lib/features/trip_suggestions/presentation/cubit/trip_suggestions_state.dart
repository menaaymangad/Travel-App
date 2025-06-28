import 'package:equatable/equatable.dart';
import '../../domain/entities/trip_suggestion.dart';

abstract class TripSuggestionsState extends Equatable {
  const TripSuggestionsState();
  @override
  List<Object?> get props => [];
}

class TripSuggestionsInitial extends TripSuggestionsState {}

class TripSuggestionsLoading extends TripSuggestionsState {}

class TripSuggestionsLoaded extends TripSuggestionsState {
  final List<TripSuggestion> suggestions;
  const TripSuggestionsLoaded(this.suggestions);
  @override
  List<Object?> get props => [suggestions];
}

class TripSuggestionsError extends TripSuggestionsState {
  final String message;
  const TripSuggestionsError(this.message);
  @override
  List<Object?> get props => [message];
}
