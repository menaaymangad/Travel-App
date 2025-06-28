import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/place.dart';

abstract class PlacesRepository {
  Future<Either<Failure, List<Place>>> getPlaces();
  Future<Either<Failure, List<Place>>> filterPlaces(
      {String? category, String? type, double? minRating});
}
