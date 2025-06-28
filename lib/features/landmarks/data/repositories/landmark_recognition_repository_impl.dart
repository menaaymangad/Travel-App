import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/usecases/recognize_landmark_usecase.dart';
import '../datasources/landmark_recognition_remote_data_source.dart';

class LandmarkRecognitionRepositoryImpl
    implements LandmarkRecognitionRepository {
  final LandmarkRecognitionRemoteDataSource remoteDataSource;
  LandmarkRecognitionRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> recognizeLandmark(String imagePath) async {
    try {
      final result = await remoteDataSource.recognizeLandmark(imagePath);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to recognize landmark'));
    }
  }
}
