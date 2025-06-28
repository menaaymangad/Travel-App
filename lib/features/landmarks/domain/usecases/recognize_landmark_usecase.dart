import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class RecognizeLandmarkParams {
  final String imagePath;
  const RecognizeLandmarkParams({required this.imagePath});
}

class RecognizeLandmarkUseCase
    implements UseCase<String, RecognizeLandmarkParams> {
  final LandmarkRecognitionRepository repository;
  RecognizeLandmarkUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(RecognizeLandmarkParams params) {
    return repository.recognizeLandmark(params.imagePath);
  }
}

abstract class LandmarkRecognitionRepository {
  Future<Either<Failure, String>> recognizeLandmark(String imagePath);
}
