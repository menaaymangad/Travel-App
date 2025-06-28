import 'package:equatable/equatable.dart';

class TripSuggestion extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> placeIds;

  const TripSuggestion({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.placeIds,
  });

  @override
  List<Object?> get props => [id, title, description, imageUrl, placeIds];
}
