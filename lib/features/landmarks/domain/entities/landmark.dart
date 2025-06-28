import 'package:equatable/equatable.dart';

/// Entity representing a landmark in a city
class Landmark extends Equatable {
  /// Unique identifier for the landmark
  final String id;

  /// Name of the landmark
  final String name;

  /// Description of the landmark
  final String description;

  /// URL or asset path to the landmark image
  final String imageUrl;

  /// Location of the landmark (city name)
  final String location;

  /// Historical period of the landmark
  final String period;

  /// Entrance fee for the landmark (if applicable)
  final double? entranceFee;

  /// Opening hours information
  final String openingHours;

  /// Rating of the landmark (out of 5)
  final double rating;

  /// Geographic coordinates of the landmark
  final Map<String, double> coordinates;

  /// Accessibility information for the landmark
  final List<String> accessibilityFeatures;

  /// Tags/categories for the landmark
  final List<String> tags;

  /// Creates a new [Landmark] instance
  const Landmark({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.location,
    required this.period,
    this.entranceFee,
    required this.openingHours,
    required this.rating,
    required this.coordinates,
    this.accessibilityFeatures = const [],
    this.tags = const [],
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        location,
        period,
        entranceFee,
        openingHours,
        rating,
        coordinates,
        accessibilityFeatures,
        tags,
      ];
}
