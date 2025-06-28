import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../cubit/landmarks_cubit.dart';
import '../cubit/landmarks_state.dart';
import 'landmark_details_page.dart';

/// Page displaying a list of landmarks
class LandmarksPage extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/landmarks';

  /// Creates a new [LandmarksPage] instance
  const LandmarksPage({Key? key}) : super(key: key);

  @override
  State<LandmarksPage> createState() => _LandmarksPageState();
}

class _LandmarksPageState extends State<LandmarksPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<LandmarksCubit>().getLandmarks();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('City Landmarks'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search landmarks...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<LandmarksCubit>().getLandmarks();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  context.read<LandmarksCubit>().searchLandmarks(value);
                } else {
                  context.read<LandmarksCubit>().getLandmarks();
                }
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<LandmarksCubit, LandmarksState>(
              builder: (context, state) {
                if (state is LandmarksLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is LandmarksLoaded) {
                  return state.landmarks.isEmpty
                      ? const Center(child: Text('No landmarks found'))
                      : ListView.builder(
                          itemCount: state.landmarks.length,
                          itemBuilder: (context, index) {
                            final landmark = state.landmarks[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    LandmarkDetailsPage.routeName,
                                    arguments: landmark.id,
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12.0),
                                        topRight: Radius.circular(12.0),
                                      ),
                                      child: Image.network(
                                        landmark.imageUrl,
                                        height: 180.0,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            height: 180.0,
                                            color: Colors.grey[300],
                                            child: const Center(
                                              child: Icon(Icons.error),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            landmark.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                          const SizedBox(height: 8.0),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on,
                                                size: 16.0,
                                                color: Colors.red,
                                              ),
                                              const SizedBox(width: 4.0),
                                              Text(
                                                landmark.location,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          Row(
                                            children: [
                                              RatingBarIndicator(
                                                rating: landmark.rating,
                                                itemBuilder: (context, index) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemCount: 5,
                                                itemSize: 20.0,
                                              ),
                                              const SizedBox(width: 8.0),
                                              Text(
                                                landmark.rating.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            landmark.description,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                } else if (state is LandmarksError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('No landmarks available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
