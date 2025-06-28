import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/post_model.dart';

abstract class SocialRemoteDataSource {
  Future<void> uploadPost(PostModel post, {File? imageFile});
  Future<List<PostModel>> fetchPosts();
}

class SocialRemoteDataSourceImpl implements SocialRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  SocialRemoteDataSourceImpl({
    required this.firestore,
    required this.storage,
  });

  @override
  Future<void> uploadPost(PostModel post, {File? imageFile}) async {
    String? imageUrl;
    if (imageFile != null) {
      final ref = storage.ref().child('post_images/${post.postId}.jpg');
      await ref.putFile(imageFile);
      imageUrl = await ref.getDownloadURL();
    }
    final postMap = PostModel(
      postId: post.postId,
      userId: post.userId,
      userName: post.userName,
      userImage: post.userImage,
      dateTime: post.dateTime,
      text: post.text,
      postImage: imageUrl ?? post.postImage,
      likes: post.likes,
      comments: post.comments,
      likesIds: post.likesIds,
    ).toMap();
    await firestore.collection('posts').doc(post.postId).set(postMap);
  }

  @override
  Future<List<PostModel>> fetchPosts() async {
    final snapshot = await firestore
        .collection('posts')
        .orderBy('dateTime', descending: true)
        .get();
    return snapshot.docs.map((doc) => PostModel.fromMap(doc.data())).toList();
  }
}
