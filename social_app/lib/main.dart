import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Layout/Social_Home/Social_Cubit/Social_Cubit.dart';
import 'package:social_app/Layout/Social_Home/social_layout.dart';
import 'package:social_app/Modules/Chats/Chats_Screen.dart';
import 'package:social_app/Modules/Edit_Profile/Edit_Profile.dart';
import 'package:social_app/Modules/Login_Screen/Login_Screen.dart';
import 'package:social_app/Modules/Register_Screen/Register_Screen.dart';
import 'package:social_app/Shared/Components/components.dart';

import 'Shared/Bloc_Observer.dart';
import 'Shared/Constants/constants.dart';
import 'Shared/Cubit/cubit.dart';
import 'Shared/Cubit/states.dart';
import 'Shared/Style/themes.dart';
import 'package:social_app/Shared/Network/remote/Dio_Helber.dart';
import 'package:social_app/Shared/Network/local/Cache_Helper.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print(message.data.toString());

  ShowToast(message: 'On background App', state: ToastStates.SUCCESS);
}

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var token = FirebaseMessaging.instance.getToken();

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());

    ShowToast(message: 'On App', state: ToastStates.SUCCESS);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());

    ShowToast(message: 'On Opened App', state: ToastStates.SUCCESS);

  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  dio_helper.init();
  await cache_helper.init();
  Widget widget;
  bool IsDark = cache_helper.GetData(key: 'IsDark');
  uID = cache_helper.GetData(key: 'uID');

  //if(FirebaseAuth.instance.currentUser == null) uID=null;

  if(uID != null) widget = socialLayout();
  else widget = SocialLoginScreen();

  runApp(MyApp(
      IsDark:IsDark,
      startwidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool IsDark;
  final Widget startwidget;
  MyApp({this.IsDark, this.startwidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()..ChangeMode(fromshared: IsDark)), 
        BlocProvider(create: (BuildContext context) => SocialCubit()..GetUserData()..getPosts())
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state) {},
        builder: (context,state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: LighteMode,
            darkTheme: DarkMode,
            themeMode: AppCubit.get(context).IsDark ? ThemeMode.light :  ThemeMode.light,
            home: startwidget,
          );
        },
      ),
    );
  }
}
