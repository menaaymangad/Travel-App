import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/filter_hotels_usecase.dart';
import '../../domain/usecases/get_hotels_by_city_usecase.dart';
import '../../domain/usecases/get_hotels_usecase.dart';
import 'hotels_state.dart';

/// Cubit for managing hotels state
class HotelsCubit extends Cubit<HotelsState> {
  /// Get hotels use case
  final GetHotelsUseCase getHotelsUseCase;

  /// Get hotels by city use case
  final GetHotelsByCityUseCase getHotelsByCityUseCase;

  /// Filter hotels use case
  final FilterHotelsUseCase filterHotelsUseCase;

  /// Creates a new [HotelsCubit] instance
  HotelsCubit({
    required this.getHotelsUseCase,
    required this.getHotelsByCityUseCase,
    required this.filterHotelsUseCase,
  }) : super(HotelsInitial());

  /// Get all hotels
  Future<void> getHotels() async {
    emit(HotelsLoading());
    final result = await getHotelsUseCase(NoParams());
    result.fold(
      (failure) => emit(HotelsError(message: failure.message)),
      (hotels) => emit(HotelsLoaded(hotels: hotels)),
    );
  }

  /// Get hotels by city
  Future<void> getHotelsByCity(String city) async {
    emit(HotelsLoading());
    final result = await getHotelsByCityUseCase(CityParams(city: city));
    result.fold(
      (failure) => emit(HotelsError(message: failure.message)),
      (hotels) => emit(HotelsLoaded(hotels: hotels)),
    );
  }

  /// Get hotel details by ID
  Future<void> getHotelDetails(String id) async {
    emit(HotelsLoading());
    // Implementation would require a specific use case
    // For now, we'll filter the hotels after fetching all
    final result = await getHotelsUseCase(NoParams());
    result.fold(
      (failure) => emit(HotelsError(message: failure.message)),
      (hotels) {
        try {
          final hotel = hotels.firstWhere(
            (hotel) => hotel.id == id,
            orElse: () => throw Exception('Hotel not found'),
          );
          emit(HotelDetailsLoaded(hotel: hotel));
        } catch (e) {
          emit(const HotelsError(message: 'Hotel not found'));
        }
      },
    );
  }

  /// Filter hotels
  Future<void> filterHotels({
    String? city,
    int? stars,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    bool sortByPrice = false,
    bool sortByRating = false,
    bool sortAscending = true,
  }) async {
    emit(HotelsLoading());
    final params = FilterParams(
      city: city,
      stars: stars,
      minPrice: minPrice,
      maxPrice: maxPrice,
      minRating: minRating,
      sortByPrice: sortByPrice,
      sortByRating: sortByRating,
      sortAscending: sortAscending,
    );
    final result = await filterHotelsUseCase(params);
    result.fold(
      (failure) => emit(HotelsError(message: failure.message)),
      (hotels) => emit(HotelsLoaded(hotels: hotels)),
    );
  }

  /// Search hotels
  Future<void> searchHotels(String query) async {
    emit(HotelsLoading());
    // Implementation would require a specific use case
    // For now, we'll filter the hotels after fetching all
    final result = await getHotelsUseCase(NoParams());
    result.fold(
      (failure) => emit(HotelsError(message: failure.message)),
      (hotels) {
        final filteredHotels = hotels
            .where((hotel) =>
                hotel.name.toLowerCase().contains(query.toLowerCase()) ||
                hotel.description.toLowerCase().contains(query.toLowerCase()) ||
                hotel.location.toLowerCase().contains(query.toLowerCase()))
            .toList();
        emit(HotelsLoaded(hotels: filteredHotels));
      },
    );
  }
}
