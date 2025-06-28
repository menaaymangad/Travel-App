abstract class TextToSpeechDataSource {
  Future<void> speakText(String text);
}

class TextToSpeechDataSourceImpl implements TextToSpeechDataSource {
  @override
  Future<void> speakText(String text) async {
    // In a real app, use flutter_tts or similar
    await Future.delayed(const Duration(milliseconds: 300));
    // Mock: print to console
    print('Speaking: $text');
  }
}
