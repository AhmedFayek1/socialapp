abstract class SocialAppStates {}

class SocialAppLoginInitialState extends SocialAppStates {}

class SocialAppLoginLoadingState extends SocialAppStates {}

class SocialAppLoginSuccessState extends SocialAppStates {
  final String uID;

  SocialAppLoginSuccessState(this.uID);
}

class SocialAppLoginErrorState extends SocialAppStates {
  final error;
  SocialAppLoginErrorState(this.error);}

class SocialAppLoginChangeText extends SocialAppStates {}