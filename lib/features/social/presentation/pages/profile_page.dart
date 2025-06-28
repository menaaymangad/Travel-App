import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp/constants/color.dart';
import 'package:travelapp/core/di/injection_container.dart';
import 'package:travelapp/features/social/presentation/cubit/social_cubit.dart';
import 'package:travelapp/features/social/presentation/cubit/social_state.dart';
import 'package:travelapp/features/social/presentation/pages/edit_profile_page.dart';

/// Profile page for displaying user information
class ProfilePage extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/profile';

  /// Creates a new [ProfilePage] instance
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                'Profile',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    // Navigate to settings
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                _buildProfileHeader(),
                const SizedBox(height: 10),
                _buildProfileStats(),
                const SizedBox(height: 20),
                _buildTabBar(),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildPostsGrid(),
                      _buildPhotosGrid(),
                      _buildSavedGrid(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/splash.png'),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'User Name',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Travel enthusiast | Egypt explorer',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushNamed(context, EditProfilePage.routeName);
                },
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Text(
            'Passionate about exploring Egypt\'s hidden gems and sharing travel tips with fellow adventurers.',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem('Posts', '24'),
        _buildStatItem('Followers', '358'),
        _buildStatItem('Following', '215'),
      ],
    );
  }

  Widget _buildStatItem(String label, String count) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      labelColor: KprimaryColor,
      unselectedLabelColor: Colors.grey,
      indicatorColor: KprimaryColor,
      tabs: const [
        Tab(icon: Icon(Icons.grid_on)),
        Tab(icon: Icon(Icons.photo_library)),
        Tab(icon: Icon(Icons.bookmark)),
      ],
    );
  }

  Widget _buildPostsGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return _buildGridItem(index);
      },
    );
  }

  Widget _buildPhotosGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return _buildGridItem(index + 10);
      },
    );
  }

  Widget _buildSavedGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return _buildGridItem(index + 20);
      },
    );
  }

  Widget _buildGridItem(int index) {
    final List<String> images = [
      'assets/images/pyra.jpg',
      'assets/images/luxor.jpg',
      'assets/images/aswan.jpg',
      'assets/images/cairotower.jpg',
      'assets/images/aswanriver.jpg',
      'assets/images/Alexandria-Library.jpg',
      'assets/images/Pyramids.jpg',
      'assets/images/karnaktemple.jpg',
      'assets/images/sohag.jpg',
      'assets/images/qena.jpg',
      'assets/images/assiut.jpg',
      'assets/images/giza.jpg',
    ];

    return Image.asset(
      images[index % images.length],
      fit: BoxFit.cover,
    );
  }
}
