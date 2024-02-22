abstract class SocialStates {}

class SocialInitialStates extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetSelectedUserLoadingState extends SocialStates {}

class SocialGetSelectedUserErrorLoadingState extends SocialStates {
  final String error;

  SocialGetSelectedUserErrorLoadingState(this.error);
}

class SocialGetUserSuccessStates extends SocialStates {}

class SocialGetUserErrorStates extends SocialStates {
  final String error;

  SocialGetUserErrorStates(this.error);
}

class GetUserLoadingState extends SocialStates {}

class GetUserSuccessState extends SocialStates {}

class GetUserErrorState extends SocialStates {
  
}

class GetCommentsLoadingState extends SocialStates {}

class GetCommentsLoadingErrorState extends SocialStates {
  final String error;
  GetCommentsLoadingErrorState(this.error);
}

class GetCommentsSuccessState extends SocialStates {}

class GetCommentsErrorState extends SocialStates {
  final String error;
  GetCommentsErrorState(this.error);
}

class GetUserFriendLoadingState extends SocialStates {}

class GetUserFriendSuccessState extends SocialStates {}

class GetUserFriendErrorState extends SocialStates {
  final String error;
  GetUserFriendErrorState(this.error);
}

class SocialGetAllUserLoadingState extends SocialStates {}

class SocialGetAllUserSuccessStates extends SocialStates {}

class SocialGetAllUserErrorStates extends SocialStates {
  final String error;

  SocialGetAllUserErrorStates(this.error);
}

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

class SocialChangeBottomNavState extends SocialStates {}

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsbyIDSuccessState extends SocialStates {}

class SocialGetPostsbyIDErrorSuccessState extends SocialStates {
  final String error;
  SocialGetPostsbyIDErrorSuccessState(this.error);
}

class SocialGetPostsErrorState extends SocialStates {
  final String error;

  SocialGetPostsErrorState(this.error);
}

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;

  SocialLikePostErrorState(this.error);
}

class SocialNewPostState extends SocialStates {}

class SocialprofileImagePickedSuccessState extends SocialStates {}

class SocialprofileImagePickedErrorState extends SocialStates {}

class SocialUploadprofileImageSuccessState extends SocialStates {}

class SocialUploadprofileImageErrorSState extends SocialStates {}

class SocialGetFollowersSuccessState extends SocialStates {}

class SocialDeletePostSuccessState extends SocialStates {}

class SocialDeletePostErrorState extends SocialStates {
  final String error;
  SocialDeletePostErrorState(this.error);
}

class SocialGetFollowersErrorState extends SocialStates {
  final String error;
  SocialGetFollowersErrorState(this.error);
}

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

class SocialUserUpdateSuccessState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {
  final String error;
  SocialUserUpdateErrorState(this.error);
}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {
  final String error;
  SocialUploadCoverImageErrorState(this.error);
}

class SocialUserUpdateLoadingState extends SocialStates {}

class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {}

class SocialGetMessageSuccessState extends SocialStates {}
