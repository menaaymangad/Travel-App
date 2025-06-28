import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_state.dart';

/// Cubit for managing chat-related state
class ChatCubit extends Cubit<ChatState> {
  /// Creates a new [ChatCubit] instance
  ChatCubit() : super(ChatInitial());

  /// Load chats data
  Future<void> loadChats() async {
    emit(ChatLoading());
    try {
      // In a real app, this would fetch data from a repository
      await Future.delayed(const Duration(seconds: 1));
      emit(ChatLoaded());
    } catch (e) {
      emit(ChatError('Failed to load chats: ${e.toString()}'));
    }
  }

  /// Send a message
  Future<void> sendMessage(String userId, String message) async {
    emit(ChatSending());
    try {
      // In a real app, this would send a message through a repository
      await Future.delayed(const Duration(milliseconds: 500));
      emit(ChatMessageSent());
    } catch (e) {
      emit(ChatError('Failed to send message: ${e.toString()}'));
    }
  }

  /// Mark a conversation as read
  Future<void> markAsRead(String userId) async {
    try {
      // In a real app, this would update read status through a repository
      await Future.delayed(const Duration(milliseconds: 300));
      emit(ChatMarkedAsRead());
    } catch (e) {
      emit(ChatError('Failed to mark as read: ${e.toString()}'));
    }
  }
}
