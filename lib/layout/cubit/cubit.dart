import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelapp/layout/cubit/states.dart';
import 'package:travelapp/modules/chat/messageModel.dart';

import '../../mainFiles/notify_screen.dart';
import '../../models/users.dart';
import '../../modules/Feeds/Feeds.dart';
import '../../views/social_login.dart';
import '../../modules/map/map_screen.dart';
import '../../modules/pesonalpage/personal_sceen.dart';
import '../../modules/places/places.dart';
import '../../modules/postscreen/postmodel.dart';
import '../../widgets/components.dart';
import '../../widgets/constants.dart';
import '../../shared/network/local/cach_helper.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialStates());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;
  SocialUserModel? selectedUser;

  List<PostModel> postsPersonal = [];
  List<String> postsIdPersonal = [];
  void getPersonalPost2() {
    //emit(GetPostPersonalLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      postsPersonal = [];
      postsIdPersonal = [];
      event.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          if (element.data()['uId'] == userModel!.uId) {
            postsIdPersonal.add(element.id);
            postsPersonal.add(PostModel.fromJson(element.data()));
          }

          //(GetPostPersonalSuccessState());
        }).catchError((error) {
          print("${error.toString()} from Personal posts");
          //(GetPostPersonalErrorState(error));
        });
      });

      //(GetPostPersonalSuccessState());
    });
  }

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      // print(value.data());
      userModel =
          SocialUserModel.fromJson(value.data() as Map<String, dynamic>);
      emit(SocialGetUserSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorStates(error.toString()));
    });
  }

  Future<SocialUserModel?> getUserDataFromId(String uid) async {
    // emit(SocialGetSelectedUserLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      // print(value.data());
      selectedUser =
          SocialUserModel.fromJson(value.data() as Map<String, dynamic>);
      //  emit(SocialGetSelectedUserLoadingState());
      return selectedUser;
    }).catchError((error) {
      print(error.toString());
      //    emit(SocialGetSelectedUserErrorLoadingState(error.toString()));
      return null;
    });
    return null;
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const FeedsScreen(),
    const placesinfo(),
    const MapScreen(),
    const Notifyme(),
    personal(),
  ];

  void changeBottomNav(int index) {
    if (index == 3) getUsers();
    currentIndex = index;
    emit(SocialChangeBottomNavState());
  }

  File? postImage;
  File? profileImage;
  var picker = ImagePicker();

  Future<void> getprofileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialprofileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialprofileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void signOut(context) {
    CachHelper.removeData(
      key: 'uId',
    ).then((value) {
      if (value) {
        navigateAndfinish(
          context,
          LoginScreen(),
        );
      }
    });
  }

  void uploadProfileImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(SocialUserUpdateLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadprofileImageSuccessState());
        updateUser(
          name: name,
          bio: bio,
          phone: phone,
          image: value,
        );
        print(value.toString());
        FirebaseFirestore.instance.collection('users').doc(uId).update({
          'image': value,
        });
      }).catchError((error) {
        emit(SocialUploadprofileImageErrorSState());
      });
    }).catchError((error) {
      emit(SocialUploadprofileImageErrorSState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String bio,
    required String phone,
  }) async {
    emit(SocialUserUpdateLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          bio: bio,
          phone: phone,
          cover: value,
        );
        FirebaseFirestore.instance.collection('users').doc(uId).update({
          'cover': value,
        });
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadCoverImageErrorState(error.toString()));
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadCoverImageErrorState(error.toString()));
    });
  }

  void updateUser(
      {required String name,
      required String bio,
      String? image,
      required String phone,
      String? cover}) {
    SocialUserModel model = SocialUserModel(
      name: name,
      bio: bio,
      phone: phone,
      email: userModel!.email,
      cover: userModel!.cover,
      image: userModel!.image,
      uId: userModel!.uId,
      isEmailVerified: false,
      followers: '',
      following: '',
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      print(getUserData);
      emit(SocialUserUpdateSuccessState());
    }).catchError((error) {
      emit(SocialUserUpdateErrorState(error.toString()));
    });
  }

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage == null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());

    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) async {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    await FirebaseFirestore.instance.collection('posts').add(model.toMap());
    emit(SocialCreatePostSuccessState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() async {
    await FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  List<PostModel> friendposts = [];
  List<String> friendpostsId = [];
  List<int> friendlikes = [];
  void getPostsByID(String uid) async {
    await FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference
            .collection('likes')
            .where("uId", isEqualTo: uid)
            .get()
            .then((value) {
          friendlikes.add(value.docs.length);
          friendpostsId.add(element.id);
          friendposts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      emit(SocialGetPostsbyIDSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetPostsbyIDErrorSuccessState(error.toString()));
    });
  }

  Future getPostsFromId(String uid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where("uId", isEqualTo: uid)
        .get();
    querySnapshot.docs.forEach((element) async {
      QuerySnapshot querySnapshot =
          await element.reference.collection('likes').get();
      likes.add(querySnapshot.docs.length);
      postsId.add(element.id);
      posts.add(PostModel.fromJson(element.data() as Map<String, dynamic>));
      print(querySnapshot.docs.length);
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];
  void getUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId) {
            users.add(SocialUserModel.fromJson(element.data()));
          }
        });
        emit(SocialGetAllUserSuccessStates());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAllUserErrorStates(error.toString()));
      });
    }
  }

  SocialUserModel? friendModel;
  List<SocialUserModel> newusers = [];
  // void getChatUsers() {
  //   emit(GetAllChatUserLoadingState());
  //   if (users.length == 0)
  //     FirebaseFirestore.instance.collection('users').get().then((value) {
  //       value.docs.forEach((element) {
  //         if (element.data()['uId'] != userModel!.uId)
  //           users.add(SocialUserModel.fromJson(element.data()));
  //       });
  //       emit(SocialGetAllChatUserSuccessState());
  //     }).catchError((error) {
  //       print(error.toString());
  //       emit(GetAllChatUserErrorState(error));
  //     });
  // }

  List<PostModel> postsFriends = [];
  List<String> postsIdFriends = [];
  void getFriendData(String userId) {
    //emit(GetUserFriendLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) {
      friendModel =
          SocialUserModel.fromJson(value.data() as Map<String, dynamic>);
      postsFriends = [];
      if (postsFriends.isEmpty) {
        getFriendPosts();
      }

      //emit(GetUserFriendSuccessState());
    }).catchError((error) {
      print("${error.toString()} in Home Cubit");
      // emit(GetUserFriendErrorState(error));
    });
  }

  PostModel? postModel;

  void getFriendPosts() {
    //emit(GetPostFriendsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        postsFriends = [];
        element.reference.collection('likes').get().then((value) {
          if (element.data()['uId'] == friendModel!.uId) {
            postsIdFriends.add(element.id);
            postsFriends.add(PostModel.fromJson(element.data()));
          }

          // emit(GetPostFriendsSuccessState());
        }).catchError((error) {
          print("${error.toString()} from Friends posts");
          // emit(GetPostFriendsErrorState(error));
        });
      });
      //emit(GetPostFriendsSuccessState());
    });
  }

  void SendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
        senderId: userModel?.uId as String,
        receiverId: receiverId,
        dateTime: dateTime,
        text: text);

    //set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
    //set receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel?.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({required String? receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }

  //get update followers value
  // void setfollowers(String postId) {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(postId)
  //       .collection('followers')
  //       .doc(userModel!.uId)
  //       .set({
  //     'followers': followers,
  //   }).then((value) {
  //     value.docs.forEach((element) {
  //       followers.add(SocialUserModel.fromJson(element.data()));
  //     });
  //     emit(SocialLikePostSuccessState());
  //     return followers;
  //   }).catchError((error) {
  //     emit(SocialLikePostErrorState(error.toString()));
  //   });
  // }

  //get all followers
  List<SocialUserModel> followers = [];
  void getFollowers(uId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('followers')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        followers.add(SocialUserModel.fromJson(element.data()));
      });
      emit(SocialGetFollowersSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetFollowersErrorState(error.toString()));
    });
  }

  List<SocialUserModel> following = [];
  void getFollowing() {
    if (following.isEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel?.uId)
          .collection('followers')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          following.add(SocialUserModel.fromJson(element.data()));
        });
        emit(SocialGetFollowersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetFollowersErrorState(error.toString()));
      });
    }
  }

  ///delete posts
  void deletePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .delete()
        .then((value) {
      emit(SocialDeletePostSuccessState());
    }).catchError((error) {
      emit(SocialDeletePostErrorState(error.toString()));
    });
  }
}
