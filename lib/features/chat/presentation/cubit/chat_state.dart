import 'package:equatable/equatable.dart';

/// Base state for chat-related states
abstract class ChatState extends Equatable {
  /// Creates a new [ChatState] instance
  const ChatState();

  @override
  List<Object?> get props => [];
}

/// Initial state for chat
class ChatInitial extends ChatState {}

/// State when chats are being loaded
class ChatLoading extends ChatState {}

/// State when chats have been loaded
class ChatLoaded extends ChatState {}

/// State when a message is being sent
class ChatSending extends ChatState {}

/// State when a message has been sent
class ChatMessageSent extends ChatState {}

/// State when a chat has been marked as read
class ChatMarkedAsRead extends ChatState {}

/// State when an error occurs
class ChatError extends ChatState {
  /// The error message
  final String message;

  /// Creates a new [ChatError] instance
  const ChatError(this.message);

  @override
  List<Object?> get props => [message];
}
