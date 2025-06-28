import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/weather_repository.dart';

/// Use case for getting recently searched cities
class GetRecentSearchesUseCase implements UseCase<List<String>, NoParams> {
  /// The weather repository
  final WeatherRepository repository;

  /// Creates a new [GetRecentSearchesUseCase] instance
  GetRecentSearchesUseCase(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) {
    return repository.getRecentSearches();
  }
}
