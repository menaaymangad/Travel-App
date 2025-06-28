import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/music.dart';
import '../repositories/music_repository.dart';

class GetCityMusicParams {
  final String? city;
  const GetCityMusicParams({this.city});
}

class GetCityMusicUseCase implements UseCase<List<Music>, GetCityMusicParams> {
  final MusicRepository repository;
  GetCityMusicUseCase(this.repository);

  @override
  Future<Either<Failure, List<Music>>> call(GetCityMusicParams params) {
    return repository.getCityMusic(city: params.city);
  }
}
