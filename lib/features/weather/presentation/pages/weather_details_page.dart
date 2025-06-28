import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../cubit/weather_cubit.dart';
import '../cubit/weather_state.dart';
import '../widgets/daily_forecast_card.dart';
import '../widgets/weather_card.dart';

/// A page that displays detailed weather forecast for a specific city
class WeatherDetailsPage extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/weather/details';

  /// The name of the city to display weather for
  final String cityName;

  /// Creates a new [WeatherDetailsPage] instance
  const WeatherDetailsPage({
    Key? key,
    required this.cityName,
  }) : super(key: key);

  @override
  State<WeatherDetailsPage> createState() => _WeatherDetailsPageState();
}

class _WeatherDetailsPageState extends State<WeatherDetailsPage> {
  @override
  void initState() {
    super.initState();
    _loadWeatherData();
  }

  /// Load weather data for the specified city
  void _loadWeatherData() {
    context.read<WeatherCubit>().getWeatherForecast(widget.cityName);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<WeatherCubit>()..getWeatherForecast(widget.cityName),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.cityName),
          actions: [
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
                child: Text('Loading weather data...'),
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
      onRefresh: () async => _loadWeatherData(),
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
            _buildHourlyForecast(context, forecast),
            const SizedBox(height: 24),
            _buildWeatherSummary(context, forecast),
          ],
        ),
      ),
    );
  }

  /// Build the hourly forecast section
  Widget _buildHourlyForecast(BuildContext context, dynamic forecast) {
    // In a real app, this would display hourly forecast data
    // For now, we'll just show a placeholder
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
              'Hourly Forecast',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  'Hourly forecast data would be displayed here',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build the weather summary section
  Widget _buildWeatherSummary(BuildContext context, dynamic forecast) {
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
              'Weather Summary',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'The weather in ${forecast.cityName} is currently ${forecast.description.toLowerCase()}. '
              'The temperature is ${forecast.currentTemp.round()}°C and feels like ${forecast.feelsLikeTemp.round()}°C. '
              'The humidity is ${forecast.humidity}% and the wind speed is ${forecast.windSpeed} km/h.',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            const Text(
              'Plan your day accordingly and stay prepared for any changes in weather conditions.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
