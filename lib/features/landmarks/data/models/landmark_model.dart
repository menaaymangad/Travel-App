import '../../domain/entities/landmark.dart';

/// Data model for a landmark
class LandmarkModel extends Landmark {
  /// Creates a new [LandmarkModel] instance
  const LandmarkModel({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    required String location,
    required String period,
    double? entranceFee,
    required String openingHours,
    required double rating,
    required Map<String, double> coordinates,
    List<String> accessibilityFeatures = const [],
    List<String> tags = const [],
  }) : super(
          id: id,
          name: name,
          description: description,
          imageUrl: imageUrl,
          location: location,
          period: period,
          entranceFee: entranceFee,
          openingHours: openingHours,
          rating: rating,
          coordinates: coordinates,
          accessibilityFeatures: accessibilityFeatures,
          tags: tags,
        );

  /// Creates a [LandmarkModel] from a JSON map
  factory LandmarkModel.fromJson(Map<String, dynamic> json) {
    return LandmarkModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      location: json['location'] as String,
      period: json['period'] as String,
      entranceFee: json['entranceFee'] != null
          ? (json['entranceFee'] as num).toDouble()
          : null,
      openingHours: json['openingHours'] as String,
      rating: (json['rating'] as num).toDouble(),
      coordinates: Map<String, double>.from(json['coordinates'] as Map),
      accessibilityFeatures: json['accessibilityFeatures'] != null
          ? List<String>.from(json['accessibilityFeatures'] as List)
          : const [],
      tags: json['tags'] != null
          ? List<String>.from(json['tags'] as List)
          : const [],
    );
  }

  /// Converts this model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'location': location,
      'period': period,
      'entranceFee': entranceFee,
      'openingHours': openingHours,
      'rating': rating,
      'coordinates': coordinates,
      'accessibilityFeatures': accessibilityFeatures,
      'tags': tags,
    };
  }
}
