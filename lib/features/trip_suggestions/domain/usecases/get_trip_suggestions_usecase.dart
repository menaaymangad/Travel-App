import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/trip_suggestion.dart';
import '../repositories/trip_suggestion_repository.dart';

class GetTripSuggestionsUseCase
    implements UseCase<List<TripSuggestion>, NoParams> {
  final TripSuggestionRepository repository;
  GetTripSuggestionsUseCase(this.repository);

  @override
  Future<Either<Failure, List<TripSuggestion>>> call(NoParams params) {
    return repository.getTripSuggestions();
  }
}
