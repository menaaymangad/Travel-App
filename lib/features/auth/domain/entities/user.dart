import 'package:equatable/equatable.dart';

/// User entity representing a user in the domain layer
class User extends Equatable {
  /// User ID
  final String uid;
  
  /// User email
  final String email;
  
  /// User name
  final String name;
  
  /// User phone number
  final String phone;
  
  /// User profile image URL
  final String image;
  
  /// User cover image URL
  final String cover;
  
  /// User bio
  final String bio;
  
  /// Whether the user's email is verified
  final bool isEmailVerified;
  
  /// User followers count or IDs
  final String followers;
  
  /// User following count or IDs
  final String following;

  /// Creates a new [User] instance
  const User({
    required this.uid,
    required this.email,
    required this.name,
    required this.phone,
    required this.image,
    required this.cover,
    required this.bio,
    required this.isEmailVerified,
    required this.followers,
    required this.following,
  });

  @override
  List<Object?> get props => [
        uid,
        email,
        name,
        phone,
        image,
        cover,
        bio,
        isEmailVerified,
        followers,
        following,
      ];
} 