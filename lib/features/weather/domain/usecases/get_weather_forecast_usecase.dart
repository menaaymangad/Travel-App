import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/weather_forecast.dart';
import '../repositories/weather_repository.dart';

/// Use case for getting weather forecast for a specific city
class GetWeatherForecastUseCase
    implements UseCase<WeatherForecast, WeatherParams> {
  /// The weather repository
  final WeatherRepository repository;

  /// Creates a new [GetWeatherForecastUseCase] instance
  GetWeatherForecastUseCase(this.repository);

  @override
  Future<Either<Failure, WeatherForecast>> call(WeatherParams params) {
    return repository.getWeatherForecast(params.cityName);
  }
}

/// Parameters for the [GetWeatherForecastUseCase]
class WeatherParams extends Equatable {
  /// The city name for which to get the forecast
  final String cityName;

  /// Creates a new [WeatherParams] instance
  const WeatherParams({required this.cityName});

  @override
  List<Object?> get props => [cityName];
}
