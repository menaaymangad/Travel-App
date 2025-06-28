import '../../domain/entities/trip_suggestion.dart';

class TripSuggestionModel extends TripSuggestion {
  const TripSuggestionModel({
    required String id,
    required String title,
    required String description,
    required String imageUrl,
    required List<String> placeIds,
  }) : super(
          id: id,
          title: title,
          description: description,
          imageUrl: imageUrl,
          placeIds: placeIds,
        );

  factory TripSuggestionModel.fromJson(Map<String, dynamic> json) {
    return TripSuggestionModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      placeIds: List<String>.from(json['placeIds'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'placeIds': placeIds,
    };
  }
}
