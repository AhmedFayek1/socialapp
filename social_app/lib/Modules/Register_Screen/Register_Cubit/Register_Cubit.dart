import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Models/Social_Model/Social_Model.dart';

import 'package:social_app/Modules/Login_Screen/SocialLoginCubit/LoginStates.dart';

import 'package:social_app/Shared/Network/remote/Dio_Helber.dart';
import 'package:social_app/Shared/Network/local/Cache_Helper.dart';

import '../../../Models/Social_Model/Social_Model.dart';
import 'Register_States.dart';

class SocialAppRegisterCubit extends Cubit<SocialAppRegisterStates> {
  SocialAppRegisterCubit() : super(SocialAppRegisterChangeText());

  static SocialAppRegisterCubit get(context) => BlocProvider.of(context);


  void userRegister({
    @required String username,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(SocialAppRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.email);
      print(value.user.uid);
      CreateUser(
          username: username,
          email: email,
          uid: value.user.uid,
          phone: phone,
      );
        }).catchError((onError) {
      print(onError);
      emit(SocialAppRegisterErrorState(onError));
    });
  }


  void CreateUser({

    @required String username,
    @required String email,
    @required String uid,
    @required String phone,
  }) {
    CreateUserData model = CreateUserData(
        name:username,
        email: email,
        phone: phone,
        uID: uid,
        image: 'https://static.vecteezy.com/system/resources/previews/005/844/323/large_2x/young-modern-redhead-woman-social-media-avatar-vector.jpg',
        cover: 'https://static.vecteezy.com/system/resources/previews/005/844/323/large_2x/young-modern-redhead-woman-social-media-avatar-vector.jpg',
        bio: "You are Beautiful ... Just Smile",
        IsEmailVerified: false
    );
    FirebaseFirestore.instance.collection('users').doc(uid).set(model.toMap()).then((value) {
      emit(SocialAppCreateUserSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(SocialAppCreateUserErrorState(onError));
    });
  }

  IconData icon = Icons.remove_red_eye_outlined;
  bool IsShown = true;

  void ChangeText() {
    IsShown = ! IsShown;
    IsShown ? icon = Icons.remove_red_eye_outlined : icon = Icons.remove_red_eye;
    emit(SocialAppRegisterChangeText());
  }
}
