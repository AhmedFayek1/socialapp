import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Layout/Social_Home/Social_Cubit/Social_Cubit.dart';
import 'package:social_app/Layout/Social_Home/Social_Cubit/Social_States.dart';
import 'package:social_app/Modules/Posts/Post_Screen.dart';

import 'package:social_app/Shared/Components/components.dart';

class socialLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state) {
        // if(state is SocialUploadePostState)
        //   {
        //     Navigateto(context, PostScreen());
        //   }
      },
      builder: (context,state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.Titles[cubit.currentindex]),
            actions: [
              IconButton(onPressed: () {
                Navigateto(context, PostScreen());},
                  icon: Icon(Icons.add)
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),

            ],
          ),
            body: cubit.Screens[cubit.currentindex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
            onTap: (index) {
               cubit.changeNavBar(index);
            },
            currentIndex: cubit.currentindex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.message),
                  label: 'Chats'
              ),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.upload_file_rounded),
              //     label: 'Post'
              // ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_on_outlined),
                  label: 'Users'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings'
              ),
            ],

          ),

        );
      }

    );
  }
}



/*
                    if(!FirebaseAuth.instance.currentUser.emailVerified)
                      Container(
                        color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline, size: 30,),
                              SizedBox(width: 15.00,),
                              Expanded(child: Text("Verify your email",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),)),
                              SizedBox(width: 10,),
                              TextButton(
                                  onPressed: () {
                                    FirebaseAuth.instance.currentUser.sendEmailVerification().then((value)
                                    {
                                      ShowToast(message: 'Check your mail', state: ToastStates.SUCCESS);
                                    });
                                  },
                                  child: Text("Send", style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold))
                              )
                            ],
                          ),
                        ),
                      )
 */
/*
ConditionalBuilder(
              condition: SocialCubit.get(context).model != null,
              builder: (context)
              {
                var model = SocialCubit.get(context).model;
                return Column(
                  children: [

                  ],
                );
              },
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
 */