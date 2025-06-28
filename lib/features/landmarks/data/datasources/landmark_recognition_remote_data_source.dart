abstract class LandmarkRecognitionRemoteDataSource {
  Future<String> recognizeLandmark(String imagePath);
}

class LandmarkRecognitionRemoteDataSourceImpl
    implements LandmarkRecognitionRemoteDataSource {
  @override
  Future<String> recognizeLandmark(String imagePath) async {
    // In a real app, use Google ML Kit or similar
    await Future.delayed(const Duration(milliseconds: 500));
    // Mock: always return 'Pyramids of Giza' for demonstration
    return 'Pyramids of Giza';
  }
}
