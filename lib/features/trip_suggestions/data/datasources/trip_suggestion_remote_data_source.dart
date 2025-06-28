import '../models/trip_suggestion_model.dart';

abstract class TripSuggestionRemoteDataSource {
  Future<List<TripSuggestionModel>> getTripSuggestions();
}

class TripSuggestionRemoteDataSourceImpl
    implements TripSuggestionRemoteDataSource {
  @override
  Future<List<TripSuggestionModel>> getTripSuggestions() async {
    // In a real app, fetch from Firebase or API
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      TripSuggestionModel(
        id: '1',
        title: 'Classic Cairo & Giza',
        description: 'Explore the Pyramids, Sphinx, and Egyptian Museum.',
        imageUrl: 'https://example.com/cairo-giza.jpg',
        placeIds: ['1', '2'],
      ),
      TripSuggestionModel(
        id: '2',
        title: 'Nile Adventure',
        description:
            'Cruise from Luxor to Aswan, visiting temples along the Nile.',
        imageUrl: 'https://example.com/nile.jpg',
        placeIds: ['3', '4'],
      ),
    ];
  }
}
