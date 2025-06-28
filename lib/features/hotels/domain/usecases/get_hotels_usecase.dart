import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../entities/hotel.dart';
import '../repositories/hotel_repository.dart';

/// Use case to get all hotels
class GetHotelsUseCase {
  /// Repository instance
  final HotelRepository repository;

  /// Creates a new [GetHotelsUseCase] instance
  GetHotelsUseCase(this.repository);

  /// Execute the use case
  Future<Either<Failure, List<Hotel>>> call(NoParams params) {
    return repository.getHotels();
  }
}

/// No parameters needed for this use case
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
