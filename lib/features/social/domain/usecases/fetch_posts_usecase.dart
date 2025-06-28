import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/post.dart';
import '../repositories/social_repository.dart';

class FetchPostsUseCase implements UseCase<List<Post>, NoParams> {
  final SocialRepository repository;
  FetchPostsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Post>>> call(NoParams params) {
    return repository.fetchPosts();
  }
}
