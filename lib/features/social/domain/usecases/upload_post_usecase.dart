import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/post.dart';
import '../repositories/social_repository.dart';

class UploadPostParams {
  final Post post;
  final String? imagePath;
  const UploadPostParams({required this.post, this.imagePath});
}

class UploadPostUseCase implements UseCase<void, UploadPostParams> {
  final SocialRepository repository;
  UploadPostUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(UploadPostParams params) {
    return repository.uploadPost(params.post, imagePath: params.imagePath);
  }
}
