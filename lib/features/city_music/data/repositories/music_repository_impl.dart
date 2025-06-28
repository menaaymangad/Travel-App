import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/music.dart';
import '../../domain/repositories/music_repository.dart';
import '../datasources/music_remote_data_source.dart';

class MusicRepositoryImpl implements MusicRepository {
  final MusicRemoteDataSource remoteDataSource;
  MusicRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Music>>> getCityMusic({String? city}) async {
    try {
      final models = await remoteDataSource.getCityMusic(city: city);
      return Right(models);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch city music'));
    }
  }
}
