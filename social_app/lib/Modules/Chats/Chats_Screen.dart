import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Layout/Social_Home/Social_Cubit/Social_Cubit.dart';
import 'package:social_app/Layout/Social_Home/Social_Cubit/Social_States.dart';
import 'package:social_app/Models/Social_Model/Social_Model.dart';
import 'package:social_app/Modules/Edit_Profile/Edit_Profile.dart';
import 'package:social_app/Modules/Friends/Friends.dart';
import 'package:social_app/Shared/Components/components.dart';

import '../../Shared/Style/color/colors.dart';
import '../Chat_Details/Chat_Details.dart';

class Chats_Screen extends StatelessWidget {
  const Chats_Screen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>
      (
        listener: (context,state) {},
      builder: (context,state) {
          var cubit = SocialCubit.get(context);
          var model = SocialCubit.get(context).model;
         return ListView.separated(
             itemBuilder: (context,index) => buildChatItem(cubit.users[index],context),
             separatorBuilder: (context,index) => Padding(
               padding: const EdgeInsets.symmetric(vertical: 5.00),
               child: Container(
                 width: double.infinity,
                 height: 1.00,
                 color: Colors.grey[300],
               ),
             ),
             itemCount: cubit.users.length
         );

      },
    );
  }


  Widget buildChatItem(CreateUserData model,context)
  {
    return InkWell(
      onTap: () {
        Navigateto(context, ChatDetails(userModel: model));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 6),
        child: Expanded(
          child: Row(
            children: [
              InkWell(
                onTap: ()
                {
                  SocialCubit.get(context).profileFriendesPosts = [];
                  SocialCubit.get(context).getProfileFriendesPosts(model.uID);
                  Navigateto(context, FriendsScreen(model));
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(model.image),
                  radius: 25.00,
                ),
              ),
              SizedBox(width: 15.00,),
              Text(model.name,style: TextStyle(height: 1.3,fontWeight: FontWeight.bold,fontSize: 25.00),),
            ],

          ),
        ),
      ),
    );
  }
}
