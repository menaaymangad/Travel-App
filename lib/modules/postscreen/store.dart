import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelapp/modules/postscreen/postmodel.dart';
import 'package:travelapp/modules/postscreen/storage.dart';

import 'package:uuid/uuid.dart';

class FirestoreMethods{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload post
  Future<String> uploadPost(
      String description,
      Uint8List file ,
      String uId,
      String username,
      String profImage,) async {
    String res = "some error occured";
    try{
      String photoUrl = await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();
      PostModel post = PostModel(
      
        dateTime: '', image: '', text: '', postImage: '', name: '', uId: '',
      );
  
      res = "success";
    }catch(err){
      res = err.toString();
    }
    return res;
  }
}