import 'package:equatable/equatable.dart';
import '../../domain/entities/landmark.dart';

/// Base state for landmarks
abstract class LandmarksState extends Equatable {
  /// Creates a new [LandmarksState] instance
  const LandmarksState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class LandmarksInitial extends LandmarksState {}

/// Loading state
class LandmarksLoading extends LandmarksState {}

/// Loaded state with landmarks
class LandmarksLoaded extends LandmarksState {
  /// List of landmarks
  final List<Landmark> landmarks;

  /// Creates a new [LandmarksLoaded] instance
  const LandmarksLoaded({required this.landmarks});

  @override
  List<Object?> get props => [landmarks];
}

/// Landmark details loaded state
class LandmarkDetailsLoaded extends LandmarksState {
  /// Landmark details
  final Landmark landmark;

  /// Creates a new [LandmarkDetailsLoaded] instance
  const LandmarkDetailsLoaded({required this.landmark});

  @override
  List<Object?> get props => [landmark];
}

/// Error state
class LandmarksError extends LandmarksState {
  /// Error message
  final String message;

  /// Creates a new [LandmarksError] instance
  const LandmarksError({required this.message});

  @override
  List<Object?> get props => [message];
}
