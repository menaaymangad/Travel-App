import 'package:flutter/material.dart';
import 'package:travelapp/features/map/presentation/pages/map_page.dart';
import 'package:travelapp/features/places/presentation/pages/places_page.dart';
import 'package:travelapp/features/social/presentation/pages/feeds_page.dart';
import 'package:travelapp/features/social/presentation/pages/profile_page.dart';
import 'package:travelapp/features/weather/presentation/pages/weather_page.dart';

/// Navigation page for the app
class NavigationPage extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/navigation';

  /// Creates a new [NavigationPage] instance
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const FeedsPage(),
    const PlacesPage(),
    const MapPage(),
    const WeatherPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: 'Places',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
