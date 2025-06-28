import '../models/music_model.dart';

abstract class MusicRemoteDataSource {
  Future<List<MusicModel>> getCityMusic({String? city});
}

class MusicRemoteDataSourceImpl implements MusicRemoteDataSource {
  @override
  Future<List<MusicModel>> getCityMusic({String? city}) async {
    // In a real app, fetch from Firebase or API
    await Future.delayed(const Duration(milliseconds: 500));
    final all = [
      MusicModel(
        id: '1',
        city: 'Cairo',
        title: 'Cairo Nights',
        artist: 'Omar Khairat',
        url: 'https://example.com/cairo-nights.mp3',
        coverImage: 'https://example.com/cairo.jpg',
        description: 'A classic instrumental piece inspired by Cairo.',
      ),
      MusicModel(
        id: '2',
        city: 'Alexandria',
        title: 'Alexandria Breeze',
        artist: 'Angham',
        url: 'https://example.com/alexandria-breeze.mp3',
        coverImage: 'https://example.com/alex.jpg',
        description: 'A popular song about Alexandria.',
      ),
    ];
    if (city != null) {
      return all.where((m) => m.city == city).toList();
    }
    return all;
  }
}
