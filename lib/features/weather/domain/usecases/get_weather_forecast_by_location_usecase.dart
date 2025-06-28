import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/weather_forecast.dart';
import '../repositories/weather_repository.dart';

/// Use case for getting weather forecast by location coordinates
class GetWeatherForecastByLocationUseCase
    implements UseCase<WeatherForecast, LocationParams> {
  /// The weather repository
  final WeatherRepository repository;

  /// Creates a new [GetWeatherForecastByLocationUseCase] instance
  GetWeatherForecastByLocationUseCase(this.repository);

  @override
  Future<Either<Failure, WeatherForecast>> call(LocationParams params) {
    return repository.getWeatherForecastByLocation(
      params.latitude,
      params.longitude,
    );
  }
}

/// Parameters for the [GetWeatherForecastByLocationUseCase]
class LocationParams extends Equatable {
  /// The latitude coordinate
  final double latitude;

  /// The longitude coordinate
  final double longitude;

  /// Creates a new [LocationParams] instance
  const LocationParams({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}
