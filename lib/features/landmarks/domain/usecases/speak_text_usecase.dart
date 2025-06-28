import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class SpeakTextParams {
  final String text;
  const SpeakTextParams({required this.text});
}

abstract class TextToSpeechRepository {
  Future<Either<Failure, void>> speakText(String text);
}

class SpeakTextUseCase implements UseCase<void, SpeakTextParams> {
  final TextToSpeechRepository repository;
  SpeakTextUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SpeakTextParams params) {
    return repository.speakText(params.text);
  }
}
