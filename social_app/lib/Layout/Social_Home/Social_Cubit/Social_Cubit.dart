import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Layout/Social_Home/Social_Cubit/Social_States.dart';
import 'package:social_app/Models/Chat_Model/Chat_Model.dart';
import 'package:social_app/Modules/Chats/Chats_Screen.dart';
import 'package:social_app/Modules/Feeds/Feeds_Screen.dart';
import 'package:social_app/Modules/Login_Screen/Login_Screen.dart';
import 'package:social_app/Modules/Settings/Settings_Screen.dart';
import 'package:social_app/Modules/Users/Users_Screen.dart';
import 'package:social_app/Shared/Constants/constants.dart';
import 'package:social_app/Shared/Network/local/Cache_Helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../Models/Post_Model/Post_Model.dart';
import '../../../Models/Social_Model/Social_Model.dart';
import '../../../Shared/Components/components.dart';


class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit() : super(SocialHomeInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  CreateUserData model;

  Future<void> GetUserData() async
  {
    emit(SocialGetDataLoadingState());

    await FirebaseFirestore.instance.
    collection('users').
    doc(uID).
    get().
    then((value)
    {
      //print(value.data());
      model = CreateUserData.fromjson(value.data());
      emit(SocialGetDataSuccessState());
    }).catchError((onError)
    {
      print(onError.toString());
      emit(SocialGetDataErrorState(onError.toString()));
    });
  }

  int currentindex = 0;
  List<Widget> Screens = [
    FeedsScreen(),
    Chats_Screen(),
    //PostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> Titles = [
    'Feeds',
    'Chats',
    //'Post'
    'Users',
    'Settings',
  ];

  void changeNavBar(index)
  {
    currentindex = index;
    if(index == 1) getUsers();
    if(index == 3) getProfilePosts();
    emit(SocialChangeNavBarState());
  }


  File profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async
  {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialUpdateProfileImageSuccessState());
    }
    else {
      emit(SocialUpdateProfileImageErrorState());
    }
  }

  void UplodeProfileImage({
    @required String name,
    @required String email,
    @required String phone,
    @required String bio,
  }) {
    firebase_storage.FirebaseStorage.
    instance.
    ref().
    child('users/${Uri
        .file(profileImage.path)
        .pathSegments
        .last}').
    putFile(profileImage).
    then((value) {
      value.ref.getDownloadURL().
      then((value) {
        print(value);
        UpdateUserData(
          name: name,
          email: email,
          phone: phone,
          image: value,
          cover: model.cover,
          bio: bio,
        );
        emit(SocialUplodeProfileImageSuccessState());
      }).
      catchError((onError) {
        emit(SocialUplodeProfileImageErrorState());
      }).
      catchError((e) {
        emit(SocialUplodeProfileImageErrorState());
      });
    });
  }


  File coverImage;
    Future<void> getCoverImage() async
    {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        coverImage = File(pickedFile.path);
        emit(SocialUpdateCoverImageSuccessState());
      }
      else {
        emit(SocialUpdateCoverImageErrorState());
      }
    }


  void UplodeCoverImage({
    @required String name,
    @required String email,
    @required String phone,
    @required String bio,
  }) {
    firebase_storage.FirebaseStorage.
    instance.
    ref().
    child('users/${Uri
        .file(coverImage.path)
        .pathSegments
        .last}').
    putFile(coverImage).
    then((p0) {
      p0.ref.getDownloadURL().
      then((value) {
        print(value);

        UpdateUserData(
          name: name,
          email: email,
          phone: phone,
          cover: value,
          image: model.image,
          bio: bio,
        );
        emit(SocialUplodeCoverImageSuccessState());
      }).
      catchError((onError) {
        emit(SocialUplodeCoverImageErrorState());
      }).
      catchError((e) {
        emit(SocialUplodeCoverImageErrorState());
      });
    });
  }


  void UpdateUserData({
        @required String name,
        @required String email,
        @required String phone,
        @required String bio,
        String image,
        String cover,
      })
  {
    print("YES");
    emit(SocialLoadingState());
    CreateUserData usermodel = CreateUserData(
        name: name,
        email: email,
        phone: phone,
        image: image??model.image,
        cover: cover??model.cover,
        uID: model.uID,
        bio: bio,
        IsEmailVerified: false);
    print("YES");

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uID)
        .update(usermodel.toMap())
        .then((value) {

      FirebaseFirestore.
      instance.
      collection('users').
      doc(uID).
      collection('posts').
      get().
      then((value) {
        value.docs.forEach((element) {
          element.reference.update({
            "name": name,
            "image": image
          });
        });
        emit(SocialGetProfilePostsSuccessState());
      }).catchError((onError) {
        emit(SocialGetProfilePostsErrorState());
      });

      emit(SocialUserUpdateDataSuccessState());
      GetUserData();
    }).catchError((onError) {
      emit(SocialUserUpdateErrorState());
    });

  }





  File postimage;
  Future<void> getpostImage() async
  {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postimage = File(pickedFile.path);
      emit(SocialUpdatePostImageSuccessState());
    }
    else {
      emit(SocialUpdatePostImageErrorState());
    }
  }

  void uploadPostImage({
    @required String text,
    @required String datetime,
  }) {
    print("LOL");
    firebase_storage.FirebaseStorage.
    instance.
    ref().
    child('posts/${Uri
        .file(postimage.path)
        .pathSegments
        .last}').
    putFile(postimage).
    then((value) {
      value.ref.getDownloadURL().
      then((value) {
        print(value);
        createPost(
          text: text,
          datetime: datetime,
          postImage: value,
        );
        emit(SocialUploadPostSuccessState());
      }).
      catchError((onError) {
        emit(SocialUploadPostErrorState());
      }).
      catchError((e) {
        emit(SocialUploadPostErrorState());
      });
    });
  }

  void RemovePostImage()
  {
    postimage = null;
    emit(SocialRemovePostImageSuccessState());
  }


  void createPost({
    @required String datetime,
    @required String text,
    String postImage,
  })
  {
    print("YES");
    emit(SocialUploadPostLoadingState());
    PostModel usermodel = PostModel(
        name: model.name,
        image: model.image,
        text: text,
        datetime: datetime,
        postImage: postImage??'',
        uId: model.uID,
    );
    FirebaseFirestore.instance
        .collection('users').
        doc(uID).
        collection('posts').
        add(usermodel.toMap())
        .then((value) {
      emit(SocialUploadPostSuccessState());
    }).catchError((onError) {
      emit(SocialUploadPostErrorState());
    });

  }


  List<PostModel> posts = [];
  List<String> id = [];
  List<int> likes = [];
  void getPosts()
  {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.
    collection('users').
    snapshots()
    .listen((event) {
      event.docs.forEach((element) {
        users.add(CreateUserData.fromjson(element.data()));
        element.reference.collection('posts').get().
        then((value) {
          likes.add(value.docs.length);
          id.add(element.id);
          value.docs.forEach((element) {
            posts.add(PostModel.fromjson(element.data()));
          });
        }).catchError((error) {
        });
      });
      emit(SocialGetPostsSuccessState());
    });
  }


  void likePosts(String postId)
  {
    FirebaseFirestore.instance.
    collection('users').
    doc(uID).
    collection('posts').
    doc(postId).
    collection('likes').
    doc(model.uID).
    set({"like":true,}).
    then((value){
      emit(SocialLikePostSuccessState());
    }
    ).catchError((e) {
      emit(SocialLikePostErrorState());
    });
  } 
  
  List<CreateUserData> users = [];
  void getUsers()
  {
    users = [];
    FirebaseFirestore.instance.collection('users').get().
    then((value) {
      value.docs.forEach((element) {
        if(element.data()['uID'] != model.uID) {
          users.add(CreateUserData.fromjson(element.data()));
        }
        emit(SocialGetUsersSuccessState());
      });
    }).catchError((error) {
      emit(SocialGetUsersErrorState());
    });
  }


  void sendChat({
      @required String receiverID,
      @required String text,
      @required String datetime,
      String image,
  })
  {
     ChatModel chatmodel = ChatModel(
         senderID: model.uID,
         receiverID: receiverID,
         text: text,
         datetime: datetime,
         image: image??null,
     );
     FirebaseFirestore.
     instance.
    collection('users').
    doc(model.uID).
    collection('chats').
    doc(receiverID).
    collection('messages').
    add(chatmodel.toMap()).
    then((value) {
      emit(SocialSendMessagesSuccessState());
     }). catchError((onError)
     {
       emit(SocialSendMessagesErrorState());
     });
     FirebaseFirestore.
     instance.
     collection('users').
     doc(receiverID).
     collection('chats').
     doc(model.uID).
     collection('messages').
     add(chatmodel.toMap()).
     then((value) {
       emit(SocialSendMessagesSuccessState());
     }). catchError((onError)
     {
       emit(SocialSendMessagesErrorState());
     });
  }

  List<ChatModel> messages = [];
  void getMessages({String receiverID})
  {
    FirebaseFirestore.
    instance.
    collection('users').
    doc(model.uID).
    collection('chats').
    doc(receiverID).
    collection('messages').
    orderBy('datetime').
    snapshots().
    listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(ChatModel.fromjson(element.data()));
      });
      emit(SocialGetMessagesSuccessState());
    });
  }


  File messageImage;
  Future<void> getMesageImage() async
  {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      messageImage = File(pickedFile.path);
      emit(SocialUpdatePostImageSuccessState());
    }
    else {
      emit(SocialUpdatePostImageErrorState());
    }
  }

  void sendImageMessage({
    @required String receiverID,
    @required String text,
    @required String datetime,
  })
  {
    firebase_storage.FirebaseStorage.
    instance.
    ref().
    child('messages/${Uri
        .file(messageImage.path)
        .pathSegments
        .last}').
    putFile(messageImage).
    then((value) {
      value.ref.getDownloadURL().then((value) {
        sendChat(
            receiverID: receiverID,
            text: text,
            datetime: datetime ,
            image: value,
        );
        emit(SocialSendImageMessageSuccessState());
      });
    }).catchError((onError) {
      emit(SocialSendMessagesErrorState());
    });
  }


  Future signOut(context)
  {
    FirebaseAuth.instance.signOut();
    cache_helper.RemoveData(key: 'uID').then((value) {
      NavigatetoFinish(context, SocialLoginScreen());
    });
  }


  List<PostModel> profilePosts = [];
  List<int> profileLikes = [];
  void getProfilePosts()
  {
    profilePosts = [];
    emit(SocialGetProfilePostsLoadingState());
    FirebaseFirestore.
    instance.
    collection('users').
    doc(uID).
    collection('posts').
    get().
    then((value) {
      value.docs.forEach((element) {
          profilePosts.add(PostModel.fromjson(element.data()));
      });
      emit(SocialGetProfilePostsSuccessState());
    }).catchError((onError) {
      emit(SocialGetProfilePostsErrorState());
    });
  }

  List<PostModel> profileFriendesPosts = [];
  void getProfileFriendesPosts(String id)
  {
    profileFriendesPosts = [];
    emit(SocialGetProfilePostsLoadingState());
    FirebaseFirestore.
    instance.
    collection('users').
    doc(id).
    collection('posts').
    get().
    then((value) {
      value.docs.forEach((element) {
        profileFriendesPosts.add(PostModel.fromjson(element.data()));
      });
      emit(SocialGetProfilePostsSuccessState());
    }).catchError((onError) {
      emit(SocialGetProfilePostsErrorState());
    });
  }




  void signOutTemp(context)
{
  cache_helper.RemoveData(key: 'uID').then((value) {
    if(value)
      {
        NavigatetoFinish(context,SocialLoginScreen());
      }
  });
}
}
