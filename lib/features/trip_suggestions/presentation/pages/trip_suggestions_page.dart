import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/trip_suggestion.dart';
import '../cubit/trip_suggestions_cubit.dart';
import '../cubit/trip_suggestions_state.dart';
import 'package:travelapp/core/di/injection_container.dart';

class TripSuggestionsPage extends StatelessWidget {
  const TripSuggestionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TripSuggestionsCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Trip Suggestions')),
        body: BlocBuilder<TripSuggestionsCubit, TripSuggestionsState>(
          builder: (context, state) {
            if (state is TripSuggestionsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TripSuggestionsLoaded) {
              if (state.suggestions.isEmpty) {
                return const Center(child: Text('No trip suggestions found.'));
              }
              return ListView.builder(
                itemCount: state.suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = state.suggestions[index];
                  return _buildSuggestionCard(context, suggestion);
                },
              );
            } else if (state is TripSuggestionsError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildSuggestionCard(BuildContext context, TripSuggestion suggestion) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 3,
      child: ListTile(
        leading: Image.network(suggestion.imageUrl,
            width: 60, height: 60, fit: BoxFit.cover),
        title: Text(suggestion.title),
        subtitle: Text(suggestion.description),
        onTap: () {
          // Navigate to trip suggestion details or show places in the trip
        },
      ),
    );
  }
}
