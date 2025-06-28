import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/post.dart';

abstract class SocialRepository {
  Future<Either<Failure, void>> uploadPost(Post post, {String? imagePath});
  Future<Either<Failure, List<Post>>> fetchPosts();
}
