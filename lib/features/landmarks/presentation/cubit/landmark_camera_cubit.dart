import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/recognize_landmark_usecase.dart';
import '../../domain/usecases/speak_text_usecase.dart';
import 'landmark_camera_state.dart';

class LandmarkCameraCubit extends Cubit<LandmarkCameraState> {
  final RecognizeLandmarkUseCase recognizeLandmarkUseCase;
  final SpeakTextUseCase speakTextUseCase;
  LandmarkCameraCubit(
      {required this.recognizeLandmarkUseCase, required this.speakTextUseCase})
      : super(LandmarkCameraInitial());

  Future<void> recognizeLandmark(String imagePath) async {
    emit(LandmarkCameraLoading());
    final result = await recognizeLandmarkUseCase(
        RecognizeLandmarkParams(imagePath: imagePath));
    result.fold(
      (failure) => emit(LandmarkCameraError(failure.message)),
      (landmark) => emit(LandmarkCameraRecognized(landmark)),
    );
  }

  Future<void> speakText(String text) async {
    await speakTextUseCase(SpeakTextParams(text: text));
  }
}
