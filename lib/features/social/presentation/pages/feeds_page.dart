import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp/constants/color.dart';
import 'package:travelapp/core/di/injection_container.dart';
import 'package:travelapp/features/social/presentation/cubit/social_cubit.dart';
import 'package:travelapp/features/social/presentation/cubit/social_state.dart';
import 'package:travelapp/features/social/presentation/models/post_model.dart';
import 'package:travelapp/features/social/presentation/pages/add_post_page.dart';

/// Feeds page for displaying social media posts
class FeedsPage extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/feeds';

  /// Creates a new [FeedsPage] instance
  const FeedsPage({Key? key}) : super(key: key);

  @override
  State<FeedsPage> createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  final List<Map<String, dynamic>> _dummyPosts = [
    {
      'userId': '1',
      'userName': 'Ahmed Hassan',
      'userImage': 'assets/images/splash.png',
      'postDate': DateTime.now().subtract(const Duration(hours: 2)),
      'postText':
          'Just visited the amazing pyramids of Giza! A must-see for everyone visiting Egypt.',
      'postImage': 'assets/images/pyra.jpg',
      'likes': 42,
      'comments': 7,
    },
    {
      'userId': '2',
      'userName': 'Sara Ahmed',
      'userImage': 'assets/images/splash.png',
      'postDate': DateTime.now().subtract(const Duration(hours: 5)),
      'postText':
          'Beautiful sunset view at Aswan. The Nile is truly magnificent!',
      'postImage': 'assets/images/aswanriver.jpg',
      'likes': 38,
      'comments': 5,
    },
    {
      'userId': '3',
      'userName': 'Mohamed Ali',
      'userImage': 'assets/images/splash.png',
      'postDate': DateTime.now().subtract(const Duration(days: 1)),
      'postText':
          'Exploring the ancient temples of Luxor. The history here is incredible.',
      'postImage': 'assets/images/luxor.jpg',
      'likes': 65,
      'comments': 12,
    },
    {
      'userId': '4',
      'userName': 'Laila Ibrahim',
      'userImage': 'assets/images/splash.png',
      'postDate': DateTime.now().subtract(const Duration(days: 2)),
      'postText': 'Cairo Tower offers the best panoramic view of the city!',
      'postImage': 'assets/images/cairotower.jpg',
      'likes': 29,
      'comments': 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SocialCubit>(),
      child: BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {
          // Handle state changes if needed
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: KprimaryColor,
              title: const Text(
                'Social Feed',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // Navigate to search page
                  },
                ),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                // Refresh posts
                await Future.delayed(const Duration(seconds: 1));
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    _buildCreatePostCard(),
                    ..._dummyPosts.map((post) => _buildPostCard(post)).toList(),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddPostPage.routeName);
              },
              backgroundColor: KprimaryColor,
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCreatePostCard() {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/splash.png'),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AddPostPage.routeName);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).dividerColor),
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Text(
                        'What\'s on your mind?',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(Icons.photo_library, 'Photos', Colors.green),
                _buildActionButton(Icons.location_on, 'Check In', Colors.red),
                _buildActionButton(
                    Icons.tag_faces, 'Feeling', Colors.amberAccent),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AddPostPage.routeName);
      },
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(post['userImage']),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['userName'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        _formatTimeAgo(post['postDate']),
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {
                    // Show post options
                  },
                ),
              ],
            ),
          ),
          if (post['postText'] != null && post['postText'].isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                post['postText'],
                style: const TextStyle(fontSize: 16),
              ),
            ),
          if (post['postImage'] != null)
            Image.asset(
              post['postImage'],
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                const Icon(Icons.favorite, color: Colors.red, size: 20),
                const SizedBox(width: 4),
                Text('${post['likes']}'),
                const Spacer(),
                Text('${post['comments']} comments'),
              ],
            ),
          ),
          const Divider(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPostAction(Icons.favorite_border, 'Like'),
              _buildPostAction(Icons.chat_bubble_outline, 'Comment'),
              _buildPostAction(Icons.share, 'Share'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPostAction(IconData icon, String label) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 20, color: Colors.grey.shade700),
      label: Text(
        label,
        style: TextStyle(color: Colors.grey.shade700),
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
}
