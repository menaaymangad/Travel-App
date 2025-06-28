import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp/constants/color.dart';
import 'package:travelapp/core/di/injection_container.dart';
import 'package:travelapp/features/map/presentation/cubit/map_cubit.dart';
import 'package:travelapp/features/map/presentation/cubit/map_state.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:travelapp/widgets/custom_button.dart';

/// Page for calculating distances between locations
class DistanceCalculatorPage extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/distance-calculator';

  /// Creates a new [DistanceCalculatorPage] instance
  const DistanceCalculatorPage({super.key});

  @override
  State<DistanceCalculatorPage> createState() => _DistanceCalculatorPageState();
}

class _DistanceCalculatorPageState extends State<DistanceCalculatorPage> {
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  final List<Map<String, dynamic>> _popularPlaces = [
    {
      'name': 'Cairo',
      'location': const LatLng(30.033333, 31.233334),
    },
    {
      'name': 'Giza',
      'location': const LatLng(29.9773, 31.1325),
    },
    {
      'name': 'Luxor',
      'location': const LatLng(25.6872, 32.6396),
    },
    {
      'name': 'Aswan',
      'location': const LatLng(24.0889, 32.8998),
    },
    {
      'name': 'Alexandria',
      'location': const LatLng(31.2001, 29.9187),
    },
  ];

  @override
  void dispose() {
    _originController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MapCubit>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: KprimaryColor,
          title: const Text(
            'Distance Calculator',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<MapCubit, MapState>(
          listener: (context, state) {
            if (state is DistanceCalculationError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _originController,
                        decoration: InputDecoration(
                          labelText: 'Origin',
                          hintText: 'Enter origin location',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.my_location),
                            onPressed: () => _showPlacesDialog(true),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _destinationController,
                        decoration: InputDecoration(
                          labelText: 'Destination',
                          hintText: 'Enter destination location',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.place),
                            onPressed: () => _showPlacesDialog(false),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        function: () {
                          if (_originController.text.isNotEmpty &&
                              _destinationController.text.isNotEmpty) {
                            context.read<MapCubit>().calculateDistanceByNames(
                                  _originController.text,
                                  _destinationController.text,
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter both locations'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        buttonName: 'Calculate Distance',
                      ),
                    ],
                  ),
                ),
                if (state is DistanceCalculationLoaded) _buildResultCard(state),
                Expanded(
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: const LatLng(30.033333, 31.233334),
                      initialZoom: 6.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: [
                          // Add markers here based on your logic
                        ],
                      ),
                      PolylineLayer(
                        polylines: <Polyline>[
                          // Add polylines here based on your logic
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'clearMap',
              onPressed: () {
                context.read<MapCubit>().clearMarkers();
                setState(() {
                  _originController.clear();
                  _destinationController.clear();
                });
              },
              backgroundColor: KprimaryColor,
              child: const Icon(Icons.clear),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(DistanceCalculationLoaded state) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Distance: ${state.distance.distanceText}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Duration: ${state.distance.durationText}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'From: ${_originController.text}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Text(
              'To: ${_destinationController.text}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPlacesDialog(bool isOrigin) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select ${isOrigin ? 'Origin' : 'Destination'}'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _popularPlaces.length,
            itemBuilder: (context, index) {
              final place = _popularPlaces[index];
              return ListTile(
                title: Text(place['name']),
                onTap: () {
                  if (isOrigin) {
                    _originController.text = place['name'];
                  } else {
                    _destinationController.text = place['name'];
                  }
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
