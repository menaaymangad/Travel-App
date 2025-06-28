import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final String id;
  final String name;
  final String category;
  final String type;
  final double rating;
  final String imageUrl;
  final String description;

  const Place({
    required this.id,
    required this.name,
    required this.category,
    required this.type,
    required this.rating,
    required this.imageUrl,
    required this.description,
  });

  @override
  List<Object?> get props =>
      [id, name, category, type, rating, imageUrl, description];
}
