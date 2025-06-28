import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp/constants/color.dart';
import 'package:travelapp/core/di/injection_container.dart';
import 'package:travelapp/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:travelapp/features/chat/presentation/cubit/chat_state.dart';
import 'package:travelapp/features/chat/presentation/pages/chat_details_page.dart';

/// Chat page for displaying a list of chat conversations
class ChatPage extends StatelessWidget {
  /// Route name for navigation
  static const String routeName = '/chat';

  /// Creates a new [ChatPage] instance
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChatCubit>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: KprimaryColor,
          title: const Text(
            'Chats',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChatError) {
              return Center(child: Text(state.message));
            } else {
              return ListView.builder(
                itemCount: _dummyChats.length,
                itemBuilder: (context, index) {
                  final chat = _dummyChats[index];
                  return _buildChatItem(context, chat);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildChatItem(BuildContext context, Map<String, dynamic> chat) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(chat['avatar']),
      ),
      title: Text(chat['name']),
      subtitle: Text(
        chat['lastMessage'],
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            chat['time'],
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 5),
          if (chat['unreadCount'] > 0)
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: KprimaryColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                chat['unreadCount'].toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailsPage(
              userId: chat['id'],
              userName: chat['name'],
            ),
          ),
        );
      },
    );
  }
}

final List<Map<String, dynamic>> _dummyChats = [
  {
    'id': '1',
    'name': 'Cairo Tour Guide',
    'avatar': 'assets/images/cairotower.jpg',
    'lastMessage': 'Hello! How can I help you with your Cairo tour?',
    'time': '10:30 AM',
    'unreadCount': 2,
  },
  {
    'id': '2',
    'name': 'Luxor Adventures',
    'avatar': 'assets/images/luxor.jpg',
    'lastMessage': 'Your booking for the Valley of Kings tour is confirmed.',
    'time': 'Yesterday',
    'unreadCount': 0,
  },
  {
    'id': '3',
    'name': 'Alexandria Explorers',
    'avatar': 'assets/images/Alexandria-Library.jpg',
    'lastMessage': 'Check out our new Mediterranean coast tour package!',
    'time': 'Yesterday',
    'unreadCount': 1,
  },
  {
    'id': '4',
    'name': 'Aswan Cruise',
    'avatar': 'assets/images/aswan.jpg',
    'lastMessage': 'Your Nile cruise will depart at 9:00 AM tomorrow.',
    'time': '2 days ago',
    'unreadCount': 0,
  },
  {
    'id': '5',
    'name': 'Giza Pyramid Tours',
    'avatar': 'assets/images/pyra.jpg',
    'lastMessage': 'Don\'t forget to bring your camera for the camel ride!',
    'time': '1 week ago',
    'unreadCount': 0,
  },
];
