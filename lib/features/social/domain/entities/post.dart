import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String postId;
  final String userId;
  final String userName;
  final String userImage;
  final DateTime dateTime;
  final String text;
  final String? postImage;
  final int likes;
  final int comments;
  final List<String> likesIds;

  const Post({
    required this.postId,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.dateTime,
    required this.text,
    this.postImage,
    this.likes = 0,
    this.comments = 0,
    this.likesIds = const [],
  });

  @override
  List<Object?> get props => [
        postId,
        userId,
        userName,
        userImage,
        dateTime,
        text,
        postImage,
        likes,
        comments,
        likesIds,
      ];
}
