import 'package:equatable/equatable.dart';

/// Entity representing a favorite item (could be a place, hotel, restaurant, etc.)
class Favorite extends Equatable {
  /// Unique ID of the favorited item
  final String id;

  /// Type of the favorited item (e.g., 'place', 'hotel', 'restaurant')
  final String type;

  /// Name of the favorited item
  final String name;

  /// Optional image URL for the favorite
  final String? imageUrl;

  /// Creates a new [Favorite] instance
  const Favorite({
    required this.id,
    required this.type,
    required this.name,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, type, name, imageUrl];
}
