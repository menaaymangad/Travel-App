import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp/constants/color.dart';
import 'package:travelapp/core/di/injection_container.dart';
import 'package:travelapp/features/transport/domain/entities/transport_cost.dart';
import 'package:travelapp/features/transport/presentation/cubit/transport_cubit.dart';
import 'package:travelapp/features/transport/presentation/cubit/transport_state.dart';
import 'package:travelapp/features/transport/presentation/pages/transport_details_page.dart';

/// Page for calculating transport costs between locations
class TransportCostPage extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/transport-cost';

  /// Creates a new [TransportCostPage] instance
  const TransportCostPage({Key? key}) : super(key: key);

  @override
  State<TransportCostPage> createState() => _TransportCostPageState();
}

class _TransportCostPageState extends State<TransportCostPage> {
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  final List<Map<String, String>> _popularPlaces = [
    {'name': 'Cairo', 'image': 'assets/images/cairotower.jpg'},
    {'name': 'Giza', 'image': 'assets/images/pyra.jpg'},
    {'name': 'Luxor', 'image': 'assets/images/luxor.jpg'},
    {'name': 'Aswan', 'image': 'assets/images/aswan.jpg'},
    {'name': 'Alexandria', 'image': 'assets/images/Alexandria-Library.jpg'},
    {
      'name': 'Sharm El Sheikh',
      'image': 'assets/images/Ras Muhammad National Park.jpg'
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
      create: (_) => sl<TransportCubit>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: Text(
            'Transport Cost Calculator',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<TransportCubit, TransportState>(
          listener: (context, state) {
            if (state is TransportError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
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
                        ElevatedButton(
                          onPressed: () {
                            if (_originController.text.isNotEmpty &&
                                _destinationController.text.isNotEmpty) {
                              context
                                  .read<TransportCubit>()
                                  .calculateTransportCosts(
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: KprimaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: state is TransportLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
                                  'Calculate Transport Costs',
                                  style: TextStyle(fontSize: 16),
                                ),
                        ),
                      ],
                    ),
                  ),
                  if (state is TransportCostsLoaded)
                    _buildTransportCostsList(context, state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTransportCostsList(
      BuildContext context, TransportCostsLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Transport options from ${state.origin} to ${state.destination}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.transportCosts.length,
          itemBuilder: (context, index) {
            final transportCost = state.transportCosts[index];
            return _buildTransportCostCard(context, transportCost);
          },
        ),
      ],
    );
  }

  Widget _buildTransportCostCard(
      BuildContext context, TransportCost transportCost) {
    // Define icon based on transport type
    IconData iconData;
    switch (transportCost.transportType) {
      case TransportType.car:
        iconData = Icons.directions_car;
        break;
      case TransportType.bus:
        iconData = Icons.directions_bus;
        break;
      case TransportType.train:
        iconData = Icons.train;
        break;
      case TransportType.plane:
        iconData = Icons.flight;
        break;
      case TransportType.boat:
        iconData = Icons.directions_boat;
        break;
      case TransportType.walking:
        iconData = Icons.directions_walk;
        break;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TransportDetailsPage(transportCost: transportCost),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: KprimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(iconData, color: KprimaryColor, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transportCost.transportTypeString,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Distance: ${transportCost.distanceInKm.toStringAsFixed(1)} km',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Duration: ${transportCost.durationString}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    transportCost.costString,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: KprimaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'View Details',
                    style: TextStyle(
                      fontSize: 12,
                      color: KprimaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
                leading: CircleAvatar(
                  backgroundImage: AssetImage(place['image']!),
                ),
                title: Text(place['name']!),
                onTap: () {
                  if (isOrigin) {
                    _originController.text = place['name']!;
                  } else {
                    _destinationController.text = place['name']!;
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
