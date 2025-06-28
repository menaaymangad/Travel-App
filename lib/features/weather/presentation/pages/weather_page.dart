import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/di/injection_container.dart';
import '../cubit/weather_cubit.dart';
import '../cubit/weather_state.dart';
import '../widgets/daily_forecast_card.dart';
import '../widgets/weather_card.dart';
import 'weather_search_page.dart';

/// A page that displays weather forecast information
class WeatherPage extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/weather';

  /// Creates a new [WeatherPage] instance
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();
    _loadWeatherData();
  }

  /// Load weather data for the current location or default city
  Future<void> _loadWeatherData() async {
    try {
      final position = await _determinePosition();
      context.read<WeatherCubit>().getWeatherForecastByLocation(
            position.latitude,
            position.longitude,
          );
    } catch (e) {
      // If location access is denied, load weather for a default city
      if (!mounted) return;
      context.read<WeatherCubit>().getWeatherForecast('Cairo');
    }
  }

  /// Determine the current position
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<WeatherCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Weather Forecast'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WeatherSearchPage(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _loadWeatherData,
            ),
          ],
        ),
        body: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WeatherLoaded) {
              return _buildWeatherContent(context, state);
            } else if (state is WeatherError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadWeatherData,
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('Search for a city to see the weather forecast'),
              );
            }
          },
        ),
      ),
    );
  }

  /// Build the weather content
  Widget _buildWeatherContent(BuildContext context, WeatherLoaded state) {
    final forecast = state.weatherForecast;

    return RefreshIndicator(
      onRefresh: _loadWeatherData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WeatherCard(
              forecast: forecast,
              showDetails: true,
            ),
            const SizedBox(height: 24),
            const Text(
              '7-Day Forecast',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: forecast.dailyForecasts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: DailyForecastCard(
                      forecast: forecast.dailyForecasts[index],
                      isToday: index == 0,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            _buildWeatherInfoCard(context),
          ],
        ),
      ),
    );
  }

  /// Build the weather information card
  Widget _buildWeatherInfoCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Weather Information',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'The weather forecast is provided by WeatherAPI.com. '
              'The forecast is updated every hour and shows the weather '
              'conditions for the next 7 days.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            const Text(
              'To see the weather for a different location, tap the search '
              'icon in the top right corner.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
