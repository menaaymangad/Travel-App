import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp/constants/color.dart';
import 'package:travelapp/core/di/injection_container.dart';
import 'package:travelapp/features/map/presentation/cubit/map_cubit.dart';
import 'package:travelapp/features/map/presentation/pages/distance_calculator_page.dart';
import 'package:travelapp/features/map/presentation/pages/places_details_page.dart';
import 'package:travelapp/features/map/presentation/pages/destinations_search_page.dart';
import 'package:travelapp/features/map/presentation/pages/travel_time_comparison_page.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;

/// Map page for displaying the map and related functionality
class MapPage extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/map';

  /// Creates a new [MapPage] instance
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MapCubit>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: KprimaryColor,
          title: const Text(
            'Egypt Map',
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
                Navigator.pushNamed(context, DestinationsSearchPage.routeName);
              },
            ),
            IconButton(
              icon: const Icon(Icons.calculate),
              onPressed: () {
                Navigator.pushNamed(context, DistanceCalculatorPage.routeName);
              },
              tooltip: 'Distance Calculator',
            ),
            IconButton(
              icon: const Icon(Icons.timer),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TravelTimeComparisonPage(
                        originName: '', destinationName: ''),
                  ),
                );
              },
              tooltip: 'Travel Time Estimation',
            ),
          ],
        ),
        body: FlutterMap(
          options: MapOptions(
            initialCenter: latlng.LatLng(30.033333, 31.233334),
            initialZoom: 6.0,
            onTap: (_, __) => _showPlacesBottomSheet(context),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 40,
                  height: 40,
                  point: latlng.LatLng(30.033333, 31.233334),
                  child: const Icon(Icons.location_on, color: Colors.red),
                ),
                Marker(
                  width: 40,
                  height: 40,
                  point: latlng.LatLng(29.9773, 31.1325),
                  child: const Icon(Icons.location_on, color: Colors.red),
                ),
                Marker(
                  width: 40,
                  height: 40,
                  point: latlng.LatLng(25.6872, 32.6396),
                  child: const Icon(Icons.location_on, color: Colors.red),
                ),
                Marker(
                  width: 40,
                  height: 40,
                  point: latlng.LatLng(24.0889, 32.8998),
                  child: const Icon(Icons.location_on, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: KprimaryColor,
          onPressed: () {
            Navigator.pushNamed(context, DistanceCalculatorPage.routeName);
          },
          tooltip: 'Calculate Distance',
          child: const Icon(Icons.directions),
        ),
      ),
    );
  }

  void _showPlacesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 200,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Popular Destinations',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildDestinationCard(
                    context,
                    'Cairo',
                    'assets/images/cairotower.jpg',
                    () => Navigator.pushNamed(
                      context,
                      PlacesDetailsPage.routeName,
                      arguments: 'cairo',
                    ),
                  ),
                  _buildDestinationCard(
                    context,
                    'Giza',
                    'assets/images/pyra.jpg',
                    () => Navigator.pushNamed(
                      context,
                      PlacesDetailsPage.routeName,
                      arguments: 'giza',
                    ),
                  ),
                  _buildDestinationCard(
                    context,
                    'Luxor',
                    'assets/images/luxor.jpg',
                    () => Navigator.pushNamed(
                      context,
                      PlacesDetailsPage.routeName,
                      arguments: 'luxor',
                    ),
                  ),
                  _buildDestinationCard(
                    context,
                    'Aswan',
                    'assets/images/aswan.jpg',
                    () => Navigator.pushNamed(
                      context,
                      PlacesDetailsPage.routeName,
                      arguments: 'aswan',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDestinationCard(
    BuildContext context,
    String title,
    String imagePath,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
