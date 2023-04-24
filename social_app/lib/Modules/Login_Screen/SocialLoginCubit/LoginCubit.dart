import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_app/Modules/Login_Screen/SocialLoginCubit/LoginStates.dart';

import 'package:social_app/Shared/Network/remote/Dio_Helber.dart';
import 'package:social_app/Shared/Network/local/Cache_Helper.dart';

class SocialAppCubit extends Cubit<SocialAppStates> {
  SocialAppCubit() : super(SocialAppLoginInitialState());

  static SocialAppCubit get(context) => BlocProvider.of(context);


   void userLogin({
     @required String email,
     @required String password
   }) {
     emit(SocialAppLoginLoadingState());
     FirebaseAuth.instance.signInWithEmailAndPassword(
         email: email,
         password: password
     ).then((value) {
       print(value.user.email);
       print(value.user.uid);
       emit(SocialAppLoginSuccessState(value.user.uid));
       }).catchError((onError) {
       print(onError);
       emit(SocialAppLoginErrorState(onError));
     });
   }

  IconData icon = Icons.remove_red_eye_outlined;
  bool IsShown = true;

  void ChangeText() {
    IsShown = ! IsShown;
    IsShown ? icon = Icons.remove_red_eye_outlined : icon = Icons.remove_red_eye;
    emit(SocialAppLoginChangeText());
  }
}
