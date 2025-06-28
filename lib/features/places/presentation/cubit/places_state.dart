import 'package:equatable/equatable.dart';
import '../../domain/entities/place.dart';

/// Base state for places-related states
abstract class PlacesState extends Equatable {
  /// Creates a new [PlacesState] instance
  const PlacesState();

  @override
  List<Object?> get props => [];
}

/// Initial state for places
class PlacesInitial extends PlacesState {}

/// State when places are being loaded
class PlacesLoading extends PlacesState {}

/// State when places are being filtered
class PlacesFiltering extends PlacesState {}

/// State when places have been filtered
class PlacesFiltered extends PlacesState {
  /// The list of places used for filtering
  final List<Place> places;

  /// Creates a new [PlacesFiltered] instance
  const PlacesFiltered(this.places);

  @override
  List<Object?> get props => [places];
}

/// State when places are being searched
class PlacesSearching extends PlacesState {}

/// State when places have been searched
class PlacesSearched extends PlacesState {
  /// The query used for searching
  final String query;

  /// Creates a new [PlacesSearched] instance
  const PlacesSearched(this.query);

  @override
  List<Object?> get props => [query];
}

/// State when an error occurs
class PlacesError extends PlacesState {
  /// The error message
  final String message;

  /// Creates a new [PlacesError] instance
  const PlacesError(this.message);

  @override
  List<Object?> get props => [message];
}
