import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/social_repository.dart';
import '../datasources/social_remote_data_source.dart';
import '../models/post_model.dart';

class SocialRepositoryImpl implements SocialRepository {
  final SocialRemoteDataSource remoteDataSource;

  SocialRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> uploadPost(Post post,
      {String? imagePath}) async {
    try {
      File? imageFile;
      if (imagePath != null) {
        imageFile = File(imagePath);
      }
      final postModel = PostModel(
        postId: post.postId,
        userId: post.userId,
        userName: post.userName,
        userImage: post.userImage,
        dateTime: post.dateTime,
        text: post.text,
        postImage: post.postImage,
        likes: post.likes,
        comments: post.comments,
        likesIds: post.likesIds,
      );
      await remoteDataSource.uploadPost(postModel, imageFile: imageFile);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to upload post'));
    }
  }

  @override
  Future<Either<Failure, List<Post>>> fetchPosts() async {
    try {
      final models = await remoteDataSource.fetchPosts();
      final posts = models
          .map((model) => Post(
                postId: model.postId,
                userId: model.userId,
                userName: model.userName,
                userImage: model.userImage,
                dateTime: model.dateTime,
                text: model.text,
                postImage: model.postImage,
                likes: model.likes,
                comments: model.comments,
                likesIds: model.likesIds,
              ))
          .toList();
      return Right(posts);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch posts'));
    }
  }
}
