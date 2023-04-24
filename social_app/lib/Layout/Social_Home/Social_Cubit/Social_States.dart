import 'package:social_app/Layout/Social_Home/Social_Cubit/Social_Cubit.dart';

abstract class SocialStates {}

class SocialHomeInitialState extends SocialStates {}

class SocialGetDataLoadingState extends SocialStates {}

class SocialGetDataSuccessState extends SocialStates {}

class SocialGetDataErrorState extends SocialStates {
  final String error;
  SocialGetDataErrorState(this.error);
}

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final String error;
  SocialGetPostsErrorState(this.error);
}

class SocialChangeNavBarState extends SocialStates {}

class SocialUploadePostState extends SocialStates {}

class SocialUpdateProfileImageSuccessState extends SocialStates {}

class SocialUpdateProfileImageErrorState extends SocialStates {}


class SocialUpdateCoverImageSuccessState extends SocialStates {}

class SocialUpdateCoverImageErrorState extends SocialStates {}

class SocialUplodeProfileImageSuccessState extends SocialStates {}

class SocialUplodeProfileImageErrorState extends SocialStates {}

class SocialUplodeCoverImageSuccessState extends SocialStates {}

class SocialUplodeCoverImageErrorState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

class SocialLoadingState extends SocialStates {}



class SocialUserUpdateDataSuccessState extends SocialStates {}

class SocialUploadPostLoadingState extends SocialStates {}


class SocialUploadPostSuccessState extends SocialStates {}

class SocialUploadPostErrorState extends SocialStates {}


class SocialUpdatePostImageSuccessState extends SocialStates {}

class SocialUpdatePostImageErrorState extends SocialStates {}

class SocialRemovePostImageSuccessState extends SocialStates {}

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {}



class SocialGetUsersSuccessState extends SocialStates {}

class SocialGetUsersErrorState extends SocialStates {}


class SocialSendMessagesSuccessState extends SocialStates {}

class SocialSendMessagesErrorState extends SocialStates {}

class SocialGetMessagesSuccessState extends SocialStates {}

class SocialGetMessagesErrorState extends SocialStates {}

class SocialSendImageMessageSuccessState extends SocialStates {}

class SocialSendImageMessageErrorState extends SocialStates {}

class SocialGetProfilePostsLoadingState extends SocialStates {}


class SocialGetProfilePostsSuccessState extends SocialStates {}

class SocialGetProfilePostsErrorState extends SocialStates {}



