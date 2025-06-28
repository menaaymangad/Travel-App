import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/weather_repository.dart';

/// Use case for saving a city to recent searches
class SaveRecentSearchUseCase implements UseCase<bool, SaveSearchParams> {
  /// The weather repository
  final WeatherRepository repository;

  /// Creates a new [SaveRecentSearchUseCase] instance
  SaveRecentSearchUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(SaveSearchParams params) {
    return repository.saveRecentSearch(params.cityName);
  }
}

/// Parameters for the [SaveRecentSearchUseCase]
class SaveSearchParams extends Equatable {
  /// The city name to save
  final String cityName;

  /// Creates a new [SaveSearchParams] instance
  const SaveSearchParams({required this.cityName});

  @override
  List<Object?> get props => [cityName];
}
