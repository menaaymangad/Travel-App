import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/hotel.dart';

/// Repository interface for hotels
abstract class HotelRepository {
  /// Get all hotels
  Future<Either<Failure, List<Hotel>>> getHotels();

  /// Get a hotel by its ID
  Future<Either<Failure, Hotel>> getHotelById(String id);

  /// Get hotels by city
  Future<Either<Failure, List<Hotel>>> getHotelsByCity(String city);

  /// Get hotels by star rating
  Future<Either<Failure, List<Hotel>>> getHotelsByStars(int stars);

  /// Get hotels by price range
  Future<Either<Failure, List<Hotel>>> getHotelsByPriceRange(
      double minPrice, double maxPrice);

  /// Search hotels by query
  Future<Either<Failure, List<Hotel>>> searchHotels(String query);
}
