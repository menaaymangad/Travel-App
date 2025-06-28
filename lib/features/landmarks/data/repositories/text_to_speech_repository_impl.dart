import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/usecases/speak_text_usecase.dart';
import '../datasources/text_to_speech_data_source.dart';

class TextToSpeechRepositoryImpl implements TextToSpeechRepository {
  final TextToSpeechDataSource dataSource;
  TextToSpeechRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, void>> speakText(String text) async {
    try {
      await dataSource.speakText(text);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to speak text'));
    }
  }
}
