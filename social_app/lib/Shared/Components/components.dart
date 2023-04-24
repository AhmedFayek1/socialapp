
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void Navigateto(context,widget) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget)
);

void NavigatetoFinish(context,widget) => Navigator.pushAndRemoveUntil(
       context,
       MaterialPageRoute(builder: (context) => widget),
       (Route<dynamic>route) => false,
);

void ShowToast({
       @required String message,
       @required ToastStates state
}) =>  Fluttertoast.showToast(
                         msg: message,
                         toastLength: Toast.LENGTH_LONG,
                         gravity: ToastGravity.BOTTOM,
                         timeInSecForIosWeb: 5,
                         backgroundColor: ShowColor(state),
                         textColor: Colors.white,
                         fontSize: 16.0
);

enum ToastStates {SUCCESS,ERROR,WARNING}

Color color;

Color ShowColor(ToastStates state)
{
         switch(state)
         {
                case ToastStates.SUCCESS:
                       color = Colors.green;
                       break;
                case ToastStates.ERROR:
                       color = Colors.red;
                       break;
                case ToastStates.WARNING:
                       color = Colors.amber;
                       break;
         }
         return color;
}
