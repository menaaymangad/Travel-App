import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp/constants/color.dart';
import 'package:travelapp/core/di/injection_container.dart';
import 'package:travelapp/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:travelapp/features/chat/presentation/models/message_model.dart';

/// Page for displaying chat details and messages
class ChatDetailsPage extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/chat-details';

  /// ID of the user to chat with
  final String userId;

  /// Name of the user to chat with
  final String userName;

  /// Creates a new [ChatDetailsPage] instance
  const ChatDetailsPage({
    Key? key,
    required this.userId,
    required this.userName,
  }) : super(key: key);

  @override
  State<ChatDetailsPage> createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<MessageModel> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadDummyMessages();
  }

  void _loadDummyMessages() {
    // In a real app, these would come from a repository
    _messages.addAll([
      MessageModel(
        senderId: widget.userId,
        receiverId: 'currentUser',
        text: 'Hello! How can I help you with your travel plans?',
        dateTime: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      ),
      MessageModel(
        senderId: 'currentUser',
        receiverId: widget.userId,
        text: 'Hi! I\'m planning to visit Egypt next month.',
        dateTime: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
      ),
      MessageModel(
        senderId: widget.userId,
        receiverId: 'currentUser',
        text: 'That\'s great! Which cities are you interested in visiting?',
        dateTime: DateTime.now().subtract(const Duration(days: 1)),
      ),
      MessageModel(
        senderId: 'currentUser',
        receiverId: widget.userId,
        text: 'I want to see Cairo, Luxor, and maybe Aswan.',
        dateTime: DateTime.now().subtract(const Duration(hours: 23)),
      ),
      MessageModel(
        senderId: widget.userId,
        receiverId: 'currentUser',
        text: 'Perfect choices! How many days are you planning to stay?',
        dateTime: DateTime.now().subtract(const Duration(hours: 22)),
      ),
    ]);
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(MessageModel(
        senderId: 'currentUser',
        receiverId: widget.userId,
        text: _messageController.text.trim(),
        dateTime: DateTime.now(),
      ));
      _messageController.clear();
    });

    // Scroll to bottom after sending message
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    // Simulate a reply after a short delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _messages.add(MessageModel(
            senderId: widget.userId,
            receiverId: 'currentUser',
            text: 'Thanks for your message! I\'ll get back to you shortly.',
            dateTime: DateTime.now(),
          ));
        });

        // Scroll to bottom after receiving reply
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChatCubit>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: KprimaryColor,
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/${widget.userId == '1' ? 'cairotower.jpg' : widget.userId == '2' ? 'luxor.jpg' : widget.userId == '3' ? 'Alexandria-Library.jpg' : widget.userId == '4' ? 'aswan.jpg' : 'pyra.jpg'}',
                ),
                radius: 20,
              ),
              const SizedBox(width: 10),
              Text(
                widget.userName,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.call),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.videocam),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isMe = message.senderId == 'currentUser';

                  return _buildMessageItem(message, isMe);
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageItem(MessageModel message, bool isMe) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/${widget.userId == '1' ? 'cairotower.jpg' : widget.userId == '2' ? 'luxor.jpg' : widget.userId == '3' ? 'Alexandria-Library.jpg' : widget.userId == '4' ? 'aswan.jpg' : 'pyra.jpg'}',
              ),
              radius: 16,
            ),
          const SizedBox(width: 8),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isMe ? KprimaryColor : Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  message.text,
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _formatTime(message.dateTime),
                  style: TextStyle(
                    color: isMe ? Colors.white70 : Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (isMe)
            CircleAvatar(
              backgroundImage: const AssetImage('assets/images/splash.png'),
              radius: 16,
            ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: () {},
            color: KprimaryColor,
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
            color: KprimaryColor,
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (messageDate == today) {
      return 'Today ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (messageDate == yesterday) {
      return 'Yesterday ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }
}
