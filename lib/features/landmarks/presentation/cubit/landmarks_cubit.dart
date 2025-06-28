import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_landmarks_usecase.dart';
import 'landmarks_state.dart';

/// Cubit for managing landmarks state
class LandmarksCubit extends Cubit<LandmarksState> {
  /// Get landmarks use case
  final GetLandmarksUseCase getLandmarksUseCase;

  /// Creates a new [LandmarksCubit] instance
  LandmarksCubit({
    required this.getLandmarksUseCase,
  }) : super(LandmarksInitial());

  /// Get all landmarks
  Future<void> getLandmarks() async {
    emit(LandmarksLoading());
    final result = await getLandmarksUseCase(NoParams());
    result.fold(
      (failure) => emit(LandmarksError(message: failure.message)),
      (landmarks) => emit(LandmarksLoaded(landmarks: landmarks)),
    );
  }

  /// Get landmarks by city
  Future<void> getLandmarksByCity(String city) async {
    emit(LandmarksLoading());
    // Implementation would require a specific use case
    // For now, we'll filter the landmarks after fetching all
    final result = await getLandmarksUseCase(NoParams());
    result.fold(
      (failure) => emit(LandmarksError(message: failure.message)),
      (landmarks) {
        final filteredLandmarks = landmarks
            .where((landmark) =>
                landmark.location.toLowerCase() == city.toLowerCase())
            .toList();
        emit(LandmarksLoaded(landmarks: filteredLandmarks));
      },
    );
  }

  /// Get landmark details by ID
  Future<void> getLandmarkDetails(String id) async {
    emit(LandmarksLoading());
    // Implementation would require a specific use case
    // For now, we'll filter the landmarks after fetching all
    final result = await getLandmarksUseCase(NoParams());
    result.fold(
      (failure) => emit(LandmarksError(message: failure.message)),
      (landmarks) {
        final landmark = landmarks.firstWhere(
          (landmark) => landmark.id == id,
          orElse: () => throw Exception('Landmark not found'),
        );
        emit(LandmarkDetailsLoaded(landmark: landmark));
      },
    );
  }

  /// Search landmarks by query
  Future<void> searchLandmarks(String query) async {
    emit(LandmarksLoading());
    // Implementation would require a specific use case
    // For now, we'll filter the landmarks after fetching all
    final result = await getLandmarksUseCase(NoParams());
    result.fold(
      (failure) => emit(LandmarksError(message: failure.message)),
      (landmarks) {
        final filteredLandmarks = landmarks
            .where((landmark) =>
                landmark.name.toLowerCase().contains(query.toLowerCase()) ||
                landmark.description
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
        emit(LandmarksLoaded(landmarks: filteredLandmarks));
      },
    );
  }
}
