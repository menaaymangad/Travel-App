import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../entities/hotel.dart';
import '../repositories/hotel_repository.dart';

/// Use case to filter hotels by various criteria
class FilterHotelsUseCase {
  /// Repository instance
  final HotelRepository repository;

  /// Creates a new [FilterHotelsUseCase] instance
  FilterHotelsUseCase(this.repository);

  /// Execute the use case
  Future<Either<Failure, List<Hotel>>> call(FilterParams params) async {
    // Get all hotels first
    final hotelsResult = await repository.getHotels();

    return hotelsResult.fold(
      (failure) => Left(failure),
      (hotels) {
        var filteredHotels = hotels;

        // Filter by city if provided
        if (params.city != null) {
          filteredHotels = filteredHotels
              .where((hotel) =>
                  hotel.location.toLowerCase() == params.city!.toLowerCase())
              .toList();
        }

        // Filter by stars if provided
        if (params.stars != null) {
          filteredHotels = filteredHotels
              .where((hotel) => hotel.stars == params.stars)
              .toList();
        }

        // Filter by price range if provided
        if (params.minPrice != null && params.maxPrice != null) {
          filteredHotels = filteredHotels
              .where((hotel) =>
                  hotel.pricePerNight >= params.minPrice! &&
                  hotel.pricePerNight <= params.maxPrice!)
              .toList();
        }

        // Filter by rating if provided
        if (params.minRating != null) {
          filteredHotels = filteredHotels
              .where((hotel) => hotel.rating >= params.minRating!)
              .toList();
        }

        // Sort by price if requested
        if (params.sortByPrice) {
          filteredHotels.sort((a, b) => params.sortAscending
              ? a.pricePerNight.compareTo(b.pricePerNight)
              : b.pricePerNight.compareTo(a.pricePerNight));
        }

        // Sort by rating if requested
        if (params.sortByRating) {
          filteredHotels.sort((a, b) => params.sortAscending
              ? a.rating.compareTo(b.rating)
              : b.rating.compareTo(a.rating));
        }

        return Right(filteredHotels);
      },
    );
  }
}

/// Parameters for the [FilterHotelsUseCase]
class FilterParams extends Equatable {
  /// City to filter by
  final String? city;

  /// Star rating to filter by
  final int? stars;

  /// Minimum price to filter by
  final double? minPrice;

  /// Maximum price to filter by
  final double? maxPrice;

  /// Minimum rating to filter by
  final double? minRating;

  /// Whether to sort by price
  final bool sortByPrice;

  /// Whether to sort by rating
  final bool sortByRating;

  /// Whether to sort in ascending order
  final bool sortAscending;

  /// Creates a new [FilterParams] instance
  const FilterParams({
    this.city,
    this.stars,
    this.minPrice,
    this.maxPrice,
    this.minRating,
    this.sortByPrice = false,
    this.sortByRating = false,
    this.sortAscending = true,
  });

  @override
  List<Object?> get props => [
        city,
        stars,
        minPrice,
        maxPrice,
        minRating,
        sortByPrice,
        sortByRating,
        sortAscending,
      ];
}
