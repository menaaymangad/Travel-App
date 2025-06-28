import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/place.dart';
import '../repositories/places_repository.dart';

class FilterPlacesParams {
  final String? category;
  final String? type;
  final double? minRating;
  const FilterPlacesParams({this.category, this.type, this.minRating});
}

class FilterPlacesUseCase implements UseCase<List<Place>, FilterPlacesParams> {
  final PlacesRepository repository;
  FilterPlacesUseCase(this.repository);

  @override
  Future<Either<Failure, List<Place>>> call(FilterPlacesParams params) {
    return repository.filterPlaces(
      category: params.category,
      type: params.type,
      minRating: params.minRating,
    );
  }
}
