import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'color/colors.dart';

ThemeData DarkMode = ThemeData(
    primarySwatch: defaultcolor,
    scaffoldBackgroundColor: HexColor("333739"),
    appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor("333739"),
            statusBarIconBrightness: Brightness.light
        ),
        color: HexColor("333739"),
        elevation: 0.0,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.00, fontWeight: FontWeight.bold,),
        iconTheme: IconThemeData(color: Colors.white,size: 30,)
    ) ,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: HexColor("333739"),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultcolor,
      unselectedItemColor: Colors.grey,
      elevation: 20.00,
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 20.00,
            fontWeight: FontWeight.w600,
            color: Colors.white
        ),
        subtitle1: TextStyle(
            fontSize: 14.00,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            height: 1.3,
    )

)
);

ThemeData LighteMode = ThemeData(
    primarySwatch: defaultcolor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        color: Colors.white,
        elevation: 0.0,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20.00, fontWeight: FontWeight.bold,),
        iconTheme: IconThemeData(color: Colors.black,size: 30,)
    ) ,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultcolor,
      unselectedItemColor: Colors.grey,
      elevation: 20.00,
    ) ,
    textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 20.00,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        subtitle1: TextStyle(
            fontSize: 16.00,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            height: 1.3,
        )

    )


);