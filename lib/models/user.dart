//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// class User {
//   final String email;
//   final String uId;
//   final String username;
//   final String postId;
//   final  datePublished;
//   final String postUrl;
//   final String profImage;
//   final  likes;
//
//   const User({
//     required  this.description,
//     required  this.uId,
//     required  this.username,
//     required  this.postId,
//     required  this.datePublished,
//     required  this.postUrl,
//     required  this.profImage,
//     required  this.likes
//   });
//   Map<String,dynamic> toJson() =>{
//     "description" : description,
//     "uId" : uId,
//     "username" : username,
//     "postId" : postId,
//     "datePublished" : datePublished,
//     "postUrl" : postUrl,
//     "profImage" : profImage,
//     "likes" : likes,
//   };
//   static User fromSnap(DocumentSnapshot snap){
//     var snapshot =snap.data() as Map<String, dynamic>;
//     return User (
//       description : snapshot['description'],
//       uId : snapshot['uId'],
//       username : snapshot['username'],
//       postId : snapshot['postId'],
//       datePublished : snapshot['datePublished'],
//       postUrl : snapshot['postUrl'],
//       profImage : snapshot['profImage'],
//       likes : snapshot['likes'],
//     );
//   }
// }