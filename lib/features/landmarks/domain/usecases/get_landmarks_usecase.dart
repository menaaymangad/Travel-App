import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../entities/landmark.dart';
import '../repositories/landmark_repository.dart';

/// Use case to get all landmarks
class GetLandmarksUseCase {
  /// Repository instance
  final LandmarkRepository repository;

  /// Creates a new [GetLandmarksUseCase] instance
  GetLandmarksUseCase(this.repository);

  /// Execute the use case
  Future<Either<Failure, List<Landmark>>> call(NoParams params) {
    return repository.getLandmarks();
  }
}

/// No parameters needed for this use case
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
