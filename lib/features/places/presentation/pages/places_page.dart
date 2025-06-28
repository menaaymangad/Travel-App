import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp/constants/color.dart';
import 'package:travelapp/core/di/injection_container.dart';
import 'package:travelapp/features/places/presentation/cubit/places_cubit.dart';
import 'package:travelapp/features/places/presentation/cubit/places_state.dart';
import 'package:travelapp/features/places/domain/entities/place.dart';
import 'package:travelapp/features/places/presentation/pages/place_details_page.dart';

/// Places page for displaying a list of places
class PlacesPage extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/places';

  /// Creates a new [PlacesPage] instance
  const PlacesPage({Key? key}) : super(key: key);

  @override
  State<PlacesPage> createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  String? _selectedCategory;
  final List<String> _categories = ['All', 'Historical', 'Market'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PlacesCubit>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: KprimaryColor,
          title: const Text(
            'Explore Places',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButton<String>(
                value: _selectedCategory ?? 'All',
                items: _categories
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() => _selectedCategory = value);
                  final cubit = context.read<PlacesCubit>();
                  if (value == 'All') {
                    cubit.filterPlaces();
                  } else {
                    cubit.filterPlaces(category: value);
                  }
                },
                isExpanded: true,
              ),
            ),
            Expanded(
              child: BlocBuilder<PlacesCubit, PlacesState>(
                builder: (context, state) {
                  if (state is PlacesFiltering) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PlacesFiltered) {
                    final places = state.places;
                    if (places.isEmpty) {
                      return const Center(child: Text('No places found.'));
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: places.length,
                      itemBuilder: (context, index) {
                        final place = places[index];
                        return _buildPlaceCard(context, place);
                      },
                    );
                  } else if (state is PlacesError) {
                    return Center(child: Text(state.message));
                  }
                  // Initial state: show empty or prompt to filter
                  return const Center(
                      child: Text('Select a category to filter places.'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceCard(BuildContext context, Place place) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlaceDetailsPage(placeId: place.id),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                place.imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    place.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      Text(place.rating.toString(),
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
