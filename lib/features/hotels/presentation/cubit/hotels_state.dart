import 'package:equatable/equatable.dart';
import '../../domain/entities/hotel.dart';

/// Base state for hotels
abstract class HotelsState extends Equatable {
  /// Creates a new [HotelsState] instance
  const HotelsState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class HotelsInitial extends HotelsState {}

/// Loading state
class HotelsLoading extends HotelsState {}

/// Loaded state with hotels
class HotelsLoaded extends HotelsState {
  /// List of hotels
  final List<Hotel> hotels;

  /// Creates a new [HotelsLoaded] instance
  const HotelsLoaded({required this.hotels});

  @override
  List<Object?> get props => [hotels];
}

/// Hotel details loaded state
class HotelDetailsLoaded extends HotelsState {
  /// Hotel details
  final Hotel hotel;

  /// Creates a new [HotelDetailsLoaded] instance
  const HotelDetailsLoaded({required this.hotel});

  @override
  List<Object?> get props => [hotel];
}

/// Error state
class HotelsError extends HotelsState {
  /// Error message
  final String message;

  /// Creates a new [HotelsError] instance
  const HotelsError({required this.message});

  @override
  List<Object?> get props => [message];
}
