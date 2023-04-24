abstract class SocialAppRegisterStates {}

class SocialAppRegisterInitialState extends SocialAppRegisterStates {}

class SocialAppRegisterLoadingState extends SocialAppRegisterStates {}

class SocialAppRegisterSuccessState extends SocialAppRegisterStates {}

class SocialAppRegisterErrorState extends SocialAppRegisterStates {
  final error;
  SocialAppRegisterErrorState(this.error);}

class SocialAppCreateUserSuccessState extends SocialAppRegisterStates {}

class SocialAppCreateUserErrorState extends SocialAppRegisterStates {
  final error;
  SocialAppCreateUserErrorState(this.error);}

class SocialAppRegisterChangeText extends SocialAppRegisterStates {}