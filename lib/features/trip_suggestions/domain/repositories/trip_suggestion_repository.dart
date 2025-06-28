import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/trip_suggestion.dart';

abstract class TripSuggestionRepository {
  Future<Either<Failure, List<TripSuggestion>>> getTripSuggestions();
}
