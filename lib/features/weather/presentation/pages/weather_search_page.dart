import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../cubit/weather_cubit.dart';
import '../cubit/weather_state.dart';
import 'weather_details_page.dart';

/// A page for searching cities and viewing weather forecasts
class WeatherSearchPage extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/weather/search';

  /// Creates a new [WeatherSearchPage] instance
  const WeatherSearchPage({Key? key}) : super(key: key);

  @override
  State<WeatherSearchPage> createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load recent searches when the page is opened
    context.read<WeatherCubit>().getRecentSearches();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<WeatherCubit>()..getRecentSearches(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search City'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for a city',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      context.read<WeatherCubit>().getRecentSearches();
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  if (value.length >= 2) {
                    context.read<WeatherCubit>().searchCities(value);
                  } else if (value.isEmpty) {
                    context.read<WeatherCubit>().getRecentSearches();
                  }
                },
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    _navigateToWeatherDetails(value);
                  }
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<WeatherCubit, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CitiesLoaded) {
                    return _buildCitiesList(context, state.cities);
                  } else if (state is RecentSearchesLoaded) {
                    return _buildRecentSearches(context, state.recentSearches);
                  } else if (state is WeatherError) {
                    return Center(
                      child: Text(
                        'Error: ${state.message}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return const Center(
                      child:
                          Text('Search for a city to see the weather forecast'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build the list of cities from search results
  Widget _buildCitiesList(BuildContext context, List<String> cities) {
    if (cities.isEmpty) {
      return const Center(
        child: Text('No cities found'),
      );
    }

    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.location_city),
          title: Text(cities[index]),
          onTap: () => _navigateToWeatherDetails(cities[index]),
        );
      },
    );
  }

  /// Build the list of recent searches
  Widget _buildRecentSearches(
      BuildContext context, List<String> recentSearches) {
    if (recentSearches.isEmpty) {
      return const Center(
        child: Text('No recent searches'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Recent Searches',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: recentSearches.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.history),
                title: Text(recentSearches[index]),
                onTap: () => _navigateToWeatherDetails(recentSearches[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Navigate to the weather details page for a specific city
  void _navigateToWeatherDetails(String cityName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeatherDetailsPage(cityName: cityName),
      ),
    );
  }
}
