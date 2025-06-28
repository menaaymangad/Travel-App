import 'package:flutter/material.dart';
import 'package:travelapp/constants/color.dart';
import 'package:travelapp/features/transport/domain/entities/transport_cost.dart';

/// Page for displaying detailed transport cost information
class TransportDetailsPage extends StatelessWidget {
  /// Route name for navigation
  static const String routeName = '/transport-details';

  /// The transport cost to display details for
  final TransportCost transportCost;

  /// Creates a new [TransportDetailsPage] instance
  const TransportDetailsPage({
    Key? key,
    required this.transportCost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KprimaryColor,
        title: Text(
          '${transportCost.transportTypeString} Details',
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            _buildRouteInfo(),
            _buildCostBreakdown(),
            _buildTravelTips(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    // Define header image based on transport type
    String headerImage;
    switch (transportCost.transportType) {
      case TransportType.car:
        headerImage = 'assets/images/route.png';
        break;
      case TransportType.bus:
        headerImage = 'assets/images/route.png';
        break;
      case TransportType.train:
        headerImage = 'assets/images/route.png';
        break;
      case TransportType.plane:
        headerImage = 'assets/images/route.png';
        break;
      case TransportType.boat:
        headerImage = 'assets/images/aswanriver.jpg';
        break;
      case TransportType.walking:
        headerImage = 'assets/images/route.png';
        break;
    }

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

    return Stack(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(headerImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: KprimaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(iconData, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transportCost.transportTypeString,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${transportCost.origin} to ${transportCost.destination}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRouteInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Route Information',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            Icons.place,
            'Origin',
            transportCost.origin,
          ),
          const Divider(),
          _buildInfoRow(
            Icons.place,
            'Destination',
            transportCost.destination,
          ),
          const Divider(),
          _buildInfoRow(
            Icons.straighten,
            'Distance',
            '${transportCost.distanceInKm.toStringAsFixed(1)} km',
          ),
          const Divider(),
          _buildInfoRow(
            Icons.access_time,
            'Duration',
            transportCost.durationString,
          ),
        ],
      ),
    );
  }

  Widget _buildCostBreakdown() {
    // Generate mock cost breakdown based on transport type
    final List<Map<String, dynamic>> costItems = [];

    switch (transportCost.transportType) {
      case TransportType.car:
        costItems.addAll([
          {'name': 'Fuel', 'cost': transportCost.costInEGP * 0.6},
          {'name': 'Tolls', 'cost': transportCost.costInEGP * 0.2},
          {'name': 'Maintenance', 'cost': transportCost.costInEGP * 0.2},
        ]);
        break;
      case TransportType.bus:
        costItems.addAll([
          {'name': 'Ticket', 'cost': transportCost.costInEGP * 0.9},
          {'name': 'Service Fee', 'cost': transportCost.costInEGP * 0.1},
        ]);
        break;
      case TransportType.train:
        costItems.addAll([
          {'name': 'Ticket', 'cost': transportCost.costInEGP * 0.85},
          {'name': 'Reservation', 'cost': transportCost.costInEGP * 0.15},
        ]);
        break;
      case TransportType.plane:
        costItems.addAll([
          {'name': 'Base Fare', 'cost': transportCost.costInEGP * 0.7},
          {'name': 'Airport Fees', 'cost': transportCost.costInEGP * 0.2},
          {'name': 'Service Charges', 'cost': transportCost.costInEGP * 0.1},
        ]);
        break;
      case TransportType.boat:
        costItems.addAll([
          {'name': 'Ticket', 'cost': transportCost.costInEGP * 0.8},
          {'name': 'Port Fees', 'cost': transportCost.costInEGP * 0.2},
        ]);
        break;
      case TransportType.walking:
        costItems.addAll([
          {'name': 'No costs', 'cost': 0.0},
        ]);
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cost Breakdown',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...costItems
              .map((item) => _buildCostItem(item['name'], item['cost'])),
          const Divider(thickness: 2),
          _buildCostItem('Total', transportCost.costInEGP, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildTravelTips() {
    // Generate travel tips based on transport type
    List<String> tips = [];

    switch (transportCost.transportType) {
      case TransportType.car:
        tips = [
          'Make sure your car is in good condition before a long trip.',
          'Check for traffic updates before departing.',
          'Keep an emergency kit in your car.',
          'Take breaks every 2 hours on long journeys.',
        ];
        break;
      case TransportType.bus:
        tips = [
          'Book tickets in advance for better prices.',
          'Arrive at the station at least 15 minutes early.',
          'Keep valuables with you at all times.',
          'Check the bus schedule for any changes.',
        ];
        break;
      case TransportType.train:
        tips = [
          'Book tickets in advance for better prices.',
          'Check your platform number before boarding.',
          'Keep your ticket accessible for inspection.',
          'Store luggage in designated areas.',
        ];
        break;
      case TransportType.plane:
        tips = [
          'Arrive at the airport 2-3 hours before departure.',
          'Check-in online to save time.',
          'Follow baggage restrictions carefully.',
          'Keep travel documents handy.',
        ];
        break;
      case TransportType.boat:
        tips = [
          'Check weather conditions before your trip.',
          'Wear comfortable clothing.',
          'Consider motion sickness medication if needed.',
          'Follow safety instructions from the crew.',
        ];
        break;
      case TransportType.walking:
        tips = [
          'Wear comfortable shoes for walking.',
          'Stay hydrated, especially in hot weather.',
          'Use sunscreen and wear a hat.',
          'Take breaks as needed during your journey.',
        ];
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Travel Tips',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...tips.map((tip) => _buildTipItem(tip)),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: KprimaryColor),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCostItem(String name, double cost, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            cost == 0 ? 'Free' : '${cost.toStringAsFixed(2)} EGP',
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? KprimaryColor : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: KprimaryColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
