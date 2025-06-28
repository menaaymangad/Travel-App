import '../../domain/entities/favorite.dart';

/// Model class for Favorite, for local storage
class FavoriteModel extends Favorite {
  const FavoriteModel({
    required String id,
    required String type,
    required String name,
    String? imageUrl,
  }) : super(id: id, type: type, name: name, imageUrl: imageUrl);

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}
