import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../cubit/landmarks_cubit.dart';
import '../cubit/landmarks_state.dart';

/// Page displaying detailed information about a landmark
class LandmarkDetailsPage extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/landmark-details';

  /// ID of the landmark to display
  final String landmarkId;

  /// Creates a new [LandmarkDetailsPage] instance
  const LandmarkDetailsPage({
    Key? key,
    required this.landmarkId,
  }) : super(key: key);

  @override
  State<LandmarkDetailsPage> createState() => _LandmarkDetailsPageState();
}

class _LandmarkDetailsPageState extends State<LandmarkDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<LandmarksCubit>().getLandmarkDetails(widget.landmarkId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LandmarksCubit, LandmarksState>(
        builder: (context, state) {
          if (state is LandmarksLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LandmarkDetailsLoaded) {
            final landmark = state.landmark;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300.0,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(landmark.name),
                    background: Hero(
                      tag: 'landmark_${landmark.id}',
                      child: Image.network(
                        landmark.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.error),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  landmark.location,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: landmark.rating,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  landmark.rating.toString(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Card(
                          elevation: 2.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Description',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  landmark.description,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Card(
                          elevation: 2.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Historical Period',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  landmark.period,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Card(
                          elevation: 2.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Visiting Information',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      'Opening Hours: ${landmark.openingHours}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                if (landmark.entranceFee != null)
                                  Row(
                                    children: [
                                      const Icon(Icons.attach_money),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        'Entrance Fee: \$${landmark.entranceFee!.toStringAsFixed(2)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Card(
                          elevation: 2.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Accessibility',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 8.0),
                                landmark.accessibilityFeatures.isEmpty
                                    ? const Text(
                                        'No accessibility information available')
                                    : Column(
                                        children: landmark.accessibilityFeatures
                                            .map(
                                              (feature) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4.0),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.check_circle,
                                                        color: Colors.green),
                                                    const SizedBox(width: 8.0),
                                                    Text(feature),
                                                  ],
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton.icon(
                          onPressed: () {
                            _launchMaps(landmark.coordinates);
                          },
                          icon: const Icon(Icons.map),
                          label: const Text('View on Map'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is LandmarksError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Landmark details not available'));
          }
        },
      ),
    );
  }

  Future<void> _launchMaps(Map<String, double> coordinates) async {
    final lat = coordinates['latitude'];
    final lng = coordinates['longitude'];
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open the map'),
          ),
        );
      }
    }
  }
}
