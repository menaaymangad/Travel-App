import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp/features/map/domain/entities/travel_time_estimate.dart';
import '../cubit/travel_time_cubit.dart';
import '../cubit/travel_time_state.dart';
import '../widgets/travel_time_card.dart';

/// A page that compares travel times between two destinations using different transport types
class TravelTimeComparisonPage extends StatefulWidget {
  /// The origin location name
  final String originName;

  /// The destination location name
  final String destinationName;

  /// Creates a new [TravelTimeComparisonPage] instance
  const TravelTimeComparisonPage({
    super.key,
    required this.originName,
    required this.destinationName,
  });

  @override
  State<TravelTimeComparisonPage> createState() =>
      _TravelTimeComparisonPageState();
}

class _TravelTimeComparisonPageState extends State<TravelTimeComparisonPage> {
  @override
  void initState() {
    super.initState();
    _loadTravelTimes();
  }

  /// Load travel times for all transport types
  void _loadTravelTimes() {
    BlocProvider.of<TravelTimeCubit>(context).estimateAllTravelTimes(
      widget.originName,
      widget.destinationName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Time Comparison'),
      ),
      body: BlocBuilder<TravelTimeCubit, TravelTimeState>(
        builder: (context, state) {
          if (state is TravelTimeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TravelTimeMultiLoaded) {
            return _buildTravelTimeComparison(state);
          } else if (state is TravelTimeError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const Center(
              child:
                  Text('Select origin and destination to compare travel times'),
            );
          }
        },
      ),
    );
  }

  /// Build the travel time comparison UI
  Widget _buildTravelTimeComparison(TravelTimeMultiLoaded state) {
    final travelTimeEstimates = state.travelTimeEstimates;

    // Sort transport types by total duration (fastest first)
    final sortedTypes = travelTimeEstimates.keys.toList()
      ..sort((a, b) {
        final aDuration = _getTotalDuration(travelTimeEstimates[a]!);
        final bDuration = _getTotalDuration(travelTimeEstimates[b]!);
        return aDuration.compareTo(bDuration);
      });

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(state),
          const SizedBox(height: 16),
          ...sortedTypes.map((type) => _buildTravelTimeCard(
                travelTimeEstimates[type]!,
                isFastest: type == sortedTypes.first,
              )),
          const SizedBox(height: 24),
          _buildFactors(),
        ],
      ),
    );
  }

  /// Build the header section with origin and destination
  Widget _buildHeader(TravelTimeMultiLoaded state) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'From ${state.origin} to ${state.destination}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Comparing travel times by different transport modes',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Build a card for a specific travel time estimate
  Widget _buildTravelTimeCard(TravelTimeEstimate estimate,
      {bool isFastest = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TravelTimeCard(
        estimate: estimate,
        isFastest: isFastest,
      ),
    );
  }

  /// Build the factors section explaining traffic and weather conditions
  Widget _buildFactors() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Factors Affecting Travel Time',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildFactorItem(
              'Traffic Conditions',
              'Traffic conditions can significantly impact road travel times. '
                  'Heavy traffic can double your journey time.',
              Icons.traffic,
            ),
            const SizedBox(height: 8),
            _buildFactorItem(
              'Weather Conditions',
              'Bad weather can affect all transport modes. '
                  'Storms can delay flights, and snow can slow down road travel.',
              Icons.wb_cloudy,
            ),
            const SizedBox(height: 8),
            _buildFactorItem(
              'Transport Mode',
              'Different transport modes have different speeds and are affected '
                  'differently by external conditions.',
              Icons.directions_car,
            ),
          ],
        ),
      ),
    );
  }

  /// Build a single factor item
  Widget _buildFactorItem(String title, String description, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.blue),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Get the total duration of a travel time estimate
  int _getTotalDuration(TravelTimeEstimate estimate) {
    return estimate.baseDurationInMinutes +
        estimate.trafficDelayInMinutes +
        estimate.weatherDelayInMinutes;
  }
}
