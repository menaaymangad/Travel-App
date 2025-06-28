import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/weather_repository.dart';

/// Use case for searching cities by name
class SearchCitiesUseCase implements UseCase<List<String>, SearchParams> {
  /// The weather repository
  final WeatherRepository repository;

  /// Creates a new [SearchCitiesUseCase] instance
  SearchCitiesUseCase(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(SearchParams params) {
    return repository.searchCities(params.query);
  }
}

/// Parameters for the [SearchCitiesUseCase]
class SearchParams extends Equatable {
  /// The search query
  final String query;

  /// Creates a new [SearchParams] instance
  const SearchParams({required this.query});

  @override
  List<Object?> get props => [query];
}
