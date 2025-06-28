import 'package:equatable/equatable.dart';

/// Model class for chat messages
class MessageModel extends Equatable {
  /// ID of the sender
  final String senderId;

  /// ID of the receiver
  final String receiverId;

  /// Text content of the message
  final String text;

  /// Date and time when the message was sent
  final DateTime dateTime;

  /// Whether the message has been read
  final bool isRead;

  /// Creates a new [MessageModel] instance
  const MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.dateTime,
    this.isRead = false,
  });

  /// Creates a [MessageModel] from a map
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      text: map['text'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      isRead: map['isRead'] as bool? ?? false,
    );
  }

  /// Converts this [MessageModel] to a map
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'isRead': isRead,
    };
  }

  @override
  List<Object?> get props => [senderId, receiverId, text, dateTime, isRead];
}
