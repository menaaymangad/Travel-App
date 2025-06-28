import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/place.dart';
import '../../domain/repositories/places_repository.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  // In a real app, inject a remote data source (e.g., Firebase)
  final List<Place> _mockPlaces = [
    Place(
      id: '1',
      name: 'Pyramids of Giza',
      category: 'Historical',
      type: 'Monument',
      rating: 4.9,
      imageUrl: 'https://example.com/pyramids.jpg',
      description: 'The last remaining wonder of the ancient world.',
    ),
    Place(
      id: '2',
      name: 'Khan el-Khalili',
      category: 'Market',
      type: 'Shopping',
      rating: 4.5,
      imageUrl: 'https://example.com/khan.jpg',
      description: 'A famous bazaar in Cairo.',
    ),
    // Add more mock places as needed
  ];

  @override
  Future<Either<Failure, List<Place>>> getPlaces() async {
    // In a real app, fetch from remote data source
    return Right(_mockPlaces);
  }

  @override
  Future<Either<Failure, List<Place>>> filterPlaces(
      {String? category, String? type, double? minRating}) async {
    try {
      List<Place> filtered = _mockPlaces;
      if (category != null) {
        filtered = filtered.where((p) => p.category == category).toList();
      }
      if (type != null) {
        filtered = filtered.where((p) => p.type == type).toList();
      }
      if (minRating != null) {
        filtered = filtered.where((p) => p.rating >= minRating).toList();
      }
      return Right(filtered);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to filter places'));
    }
  }
}
