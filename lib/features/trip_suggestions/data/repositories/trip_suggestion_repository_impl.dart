import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/trip_suggestion.dart';
import '../../domain/repositories/trip_suggestion_repository.dart';
import '../datasources/trip_suggestion_remote_data_source.dart';

class TripSuggestionRepositoryImpl implements TripSuggestionRepository {
  final TripSuggestionRemoteDataSource remoteDataSource;
  TripSuggestionRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<TripSuggestion>>> getTripSuggestions() async {
    try {
      final models = await remoteDataSource.getTripSuggestions();
      return Right(models);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch trip suggestions'));
    }
  }
}
