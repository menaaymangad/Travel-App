import '../../domain/entities/user.dart';

/// Model class for User entity
class UserModel extends User {
  /// Creates a new [UserModel] instance
  const UserModel({
    required String uid,
    required String email,
    required String name,
    required String phone,
    required String image,
    required String cover,
    required String bio,
    required bool isEmailVerified,
    required String followers,
    required String following,
  }) : super(
          uid: uid,
          email: email,
          name: name,
          phone: phone,
          image: image,
          cover: cover,
          bio: bio,
          isEmailVerified: isEmailVerified,
          followers: followers,
          following: following,
        );

  /// Creates a [UserModel] from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uId'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'] ?? '',
      cover: json['cover'] ?? '',
      bio: json['bio'] ?? '',
      isEmailVerified: json['isEmailVerified'] ?? false,
      followers: json['followers'] ?? '',
      following: json['following'] ?? '',
    );
  }

  /// Converts the [UserModel] to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'uId': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'image': image,
      'cover': cover,
      'bio': bio,
      'isEmailVerified': isEmailVerified,
      'followers': followers,
      'following': following,
    };
  }

  /// Creates a copy of this [UserModel] with the given fields replaced
  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? phone,
    String? image,
    String? cover,
    String? bio,
    bool? isEmailVerified,
    String? followers,
    String? following,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      cover: cover ?? this.cover,
      bio: bio ?? this.bio,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }
} 