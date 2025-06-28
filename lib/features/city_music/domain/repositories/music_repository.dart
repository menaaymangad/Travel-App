import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/music.dart';

abstract class MusicRepository {
  Future<Either<Failure, List<Music>>> getCityMusic({String? city});
}
