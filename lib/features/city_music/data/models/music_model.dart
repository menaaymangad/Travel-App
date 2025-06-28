import '../../domain/entities/music.dart';

class MusicModel extends Music {
  const MusicModel({
    required String id,
    required String city,
    required String title,
    required String artist,
    required String url,
    required String coverImage,
    required String description,
  }) : super(
          id: id,
          city: city,
          title: title,
          artist: artist,
          url: url,
          coverImage: coverImage,
          description: description,
        );

  factory MusicModel.fromJson(Map<String, dynamic> json) {
    return MusicModel(
      id: json['id'],
      city: json['city'],
      title: json['title'],
      artist: json['artist'],
      url: json['url'],
      coverImage: json['coverImage'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'city': city,
      'title': title,
      'artist': artist,
      'url': url,
      'coverImage': coverImage,
      'description': description,
    };
  }
}
