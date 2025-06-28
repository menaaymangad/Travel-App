import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/landmark.dart';

/// Repository interface for landmarks
abstract class LandmarkRepository {
  /// Get all landmarks
  Future<Either<Failure, List<Landmark>>> getLandmarks();

  /// Get a landmark by its ID
  Future<Either<Failure, Landmark>> getLandmarkById(String id);

  /// Get landmarks by city
  Future<Either<Failure, List<Landmark>>> getLandmarksByCity(String city);

  /// Get landmarks by tags
  Future<Either<Failure, List<Landmark>>> getLandmarksByTags(List<String> tags);

  /// Search landmarks by query
  Future<Either<Failure, List<Landmark>>> searchLandmarks(String query);
}
