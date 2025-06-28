import 'package:equatable/equatable.dart';

/// Model class for social media posts (data layer)
class PostModel extends Equatable {
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

  const PostModel({
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

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      postId: map['postId'] as String,
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      userImage: map['userImage'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      text: map['text'] as String,
      postImage: map['postImage'] as String?,
      likes: map['likes'] as int? ?? 0,
      comments: map['comments'] as int? ?? 0,
      likesIds: List<String>.from(map['likesIds'] as List<dynamic>? ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'text': text,
      'postImage': postImage,
      'likes': likes,
      'comments': comments,
      'likesIds': likesIds,
    };
  }

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
