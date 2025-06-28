import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_recent_searches_usecase.dart';
import '../../domain/usecases/get_weather_forecast_by_location_usecase.dart';
import '../../domain/usecases/get_weather_forecast_usecase.dart';
import '../../domain/usecases/save_recent_search_usecase.dart';
import '../../domain/usecases/search_cities_usecase.dart';
import 'weather_state.dart';

/// Cubit for managing weather-related state
class WeatherCubit extends Cubit<WeatherState> {
  /// Use case for getting weather forecast
  final GetWeatherForecastUseCase getWeatherForecastUseCase;

  /// Use case for getting weather forecast by location
  final GetWeatherForecastByLocationUseCase getWeatherForecastByLocationUseCase;

  /// Use case for searching cities
  final SearchCitiesUseCase searchCitiesUseCase;

  /// Use case for getting recent searches
  final GetRecentSearchesUseCase getRecentSearchesUseCase;

  /// Use case for saving recent searches
  final SaveRecentSearchUseCase saveRecentSearchUseCase;

  /// Creates a new [WeatherCubit] instance
  WeatherCubit({
    required this.getWeatherForecastUseCase,
    required this.getWeatherForecastByLocationUseCase,
    required this.searchCitiesUseCase,
    required this.getRecentSearchesUseCase,
    required this.saveRecentSearchUseCase,
  }) : super(WeatherInitial());

  /// Get weather forecast for a specific city
  Future<void> getWeatherForecast(String cityName) async {
    emit(WeatherLoading());

    final params = WeatherParams(cityName: cityName);
    final result = await getWeatherForecastUseCase(params);

    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (weatherForecast) => emit(WeatherLoaded(weatherForecast)),
    );

    // Save the search regardless of the result
    await saveRecentSearch(cityName);
  }

  /// Get weather forecast for current location
  Future<void> getWeatherForecastByLocation(
    double latitude,
    double longitude,
  ) async {
    emit(WeatherLoading());

    final params = LocationParams(
      latitude: latitude,
      longitude: longitude,
    );

    final result = await getWeatherForecastByLocationUseCase(params);

    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (weatherForecast) => emit(WeatherLoaded(weatherForecast)),
    );
  }

  /// Search for cities by name
  Future<void> searchCities(String query) async {
    if (query.isEmpty) {
      await getRecentSearches();
      return;
    }

    final params = SearchParams(query: query);
    final result = await searchCitiesUseCase(params);

    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (cities) => emit(CitiesLoaded(cities)),
    );
  }

  /// Get recently searched cities
  Future<void> getRecentSearches() async {
    final result = await getRecentSearchesUseCase(NoParams());

    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (recentSearches) => emit(RecentSearchesLoaded(recentSearches)),
    );
  }

  /// Save a city to recent searches
  Future<void> saveRecentSearch(String cityName) async {
    final params = SaveSearchParams(cityName: cityName);
    await saveRecentSearchUseCase(params);
  }
}
