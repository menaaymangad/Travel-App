import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../entities/hotel.dart';
import '../repositories/hotel_repository.dart';

/// Use case to get hotels by city
class GetHotelsByCityUseCase {
  /// Repository instance
  final HotelRepository repository;

  /// Creates a new [GetHotelsByCityUseCase] instance
  GetHotelsByCityUseCase(this.repository);

  /// Execute the use case
  Future<Either<Failure, List<Hotel>>> call(CityParams params) {
    return repository.getHotelsByCity(params.city);
  }
}

/// Parameters for the [GetHotelsByCityUseCase]
class CityParams extends Equatable {
  /// City name
  final String city;

  /// Creates a new [CityParams] instance
  const CityParams({required this.city});

  @override
  List<Object?> get props => [city];
}
