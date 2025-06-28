import 'package:equatable/equatable.dart';

/// Model class for social media posts
class PostModel extends Equatable {
  /// ID of the post
  final String postId;

  /// ID of the user who created the post
  final String userId;

  /// Name of the user who created the post
  final String userName;

  /// Profile image of the user who created the post
  final String userImage;

  /// Date and time when the post was created
  final DateTime dateTime;

  /// Text content of the post
  final String text;

  /// Image URL of the post (optional)
  final String? postImage;

  /// Number of likes on the post
  final int likes;

  /// Number of comments on the post
  final int comments;

  /// List of user IDs who liked the post
  final List<String> likesIds;

  /// Creates a new [PostModel] instance
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

  /// Creates a [PostModel] from a map
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

  /// Converts this [PostModel] to a map
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

  /// Creates a copy of this [PostModel] with the given fields replaced
  PostModel copyWith({
    String? postId,
    String? userId,
    String? userName,
    String? userImage,
    DateTime? dateTime,
    String? text,
    String? postImage,
    int? likes,
    int? comments,
    List<String>? likesIds,
  }) {
    return PostModel(
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      dateTime: dateTime ?? this.dateTime,
      text: text ?? this.text,
      postImage: postImage ?? this.postImage,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      likesIds: likesIds ?? this.likesIds,
    );
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
