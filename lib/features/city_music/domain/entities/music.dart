import 'package:equatable/equatable.dart';

class Music extends Equatable {
  final String id;
  final String city;
  final String title;
  final String artist;
  final String url;
  final String coverImage;
  final String description;

  const Music({
    required this.id,
    required this.city,
    required this.title,
    required this.artist,
    required this.url,
    required this.coverImage,
    required this.description,
  });

  @override
  List<Object?> get props =>
      [id, city, title, artist, url, coverImage, description];
}
