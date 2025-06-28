import 'package:flutter/material.dart';
import 'package:travelapp/features/map/presentation/pages/places_details_page.dart';
import 'package:travelapp/widgets/custom_text_field.dart';

/// Page for searching destinations
class DestinationsSearchPage extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/destinations-search';

  /// Creates a new [DestinationsSearchPage] instance
  const DestinationsSearchPage({super.key});

  @override
  State<DestinationsSearchPage> createState() => _DestinationsSearchPageState();
}

class _DestinationsSearchPageState extends State<DestinationsSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredDestinations = [];
  final List<Map<String, dynamic>> _allDestinations = [
    {
      'id': 'cairo',
      'name': 'Cairo',
      'image': 'assets/images/cairotower.jpg',
      'description': 'The capital of Egypt',
    },
    {
      'id': 'giza',
      'name': 'Giza',
      'image': 'assets/images/pyra.jpg',
      'description': 'Home of the Great Pyramids',
    },
    {
      'id': 'luxor',
      'name': 'Luxor',
      'image': 'assets/images/luxor.jpg',
      'description': 'Ancient Egyptian monuments',
    },
    {
      'id': 'aswan',
      'name': 'Aswan',
      'image': 'assets/images/aswan.jpg',
      'description': 'Beautiful Nile views',
    },
    {
      'id': 'alexandria',
      'name': 'Alexandria',
      'image': 'assets/images/Alexandria-Library.jpg',
      'description': 'Mediterranean coastal city',
    },
    {
      'id': 'sharm',
      'name': 'Sharm El Sheikh',
      'image': 'assets/images/Ras Muhammad National Park.jpg',
      'description': 'Popular beach resort town',
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredDestinations = _allDestinations;
    _searchController.addListener(_filterDestinations);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterDestinations() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredDestinations = _allDestinations;
      } else {
        _filteredDestinations = _allDestinations
            .where((destination) =>
                destination['name'].toLowerCase().contains(query) ||
                destination['description'].toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _onSearchChanged() {
    _filterDestinations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          'Find Destinations',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomTextField(
              controller: _searchController,
              hint: 'Search destinations...',
              label: 'Search',
              suffixIcon: const Icon(Icons.search),
              onChanged: (value) => _onSearchChanged(),
            ),
          ),
          Expanded(
            child: _filteredDestinations.isEmpty
                ? Center(
                    child: Text(
                      'No destinations found',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredDestinations.length,
                    itemBuilder: (context, index) {
                      final destination = _filteredDestinations[index];
                      return _buildDestinationCard(
                        context,
                        destination['id'],
                        destination['name'],
                        destination['description'],
                        destination['image'],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationCard(
    BuildContext context,
    String id,
    String name,
    String description,
    String imagePath,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlacesDetailsPage(placeId: id),
            ),
          );
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.asset(
                imagePath,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: const [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Icon(Icons.star_half, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text('4.5', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
