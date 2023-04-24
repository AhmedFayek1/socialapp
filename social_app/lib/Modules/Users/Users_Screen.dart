import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Layout/Social_Home/Social_Cubit/Social_Cubit.dart';

import '../../Shared/Components/components.dart';
import '../Friends/Friends.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConditionalBuilder(
          condition: SocialCubit.get(context).users.length != 0,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.00),
            child: ListView.separated(
                itemBuilder: (context,index) => Column(
                  children: [
                    Container(
                      height: 80.00,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: ()
                            {
                              SocialCubit.get(context).getProfileFriendesPosts(SocialCubit.get(context).users[index].uID);
                              Navigateto(context, FriendsScreen(SocialCubit.get(context).users[index]));
                            },
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(SocialCubit.get(context).users[index].image),
                              radius: 25.00,
                            ),
                          ),
                          SizedBox(width: 15.00,),
                          Text(SocialCubit.get(context).users[index].name,style: TextStyle(height: 1.3,fontWeight: FontWeight.bold,fontSize: 25.00),),
                        ],

                      ),
                    ),
                  ],
                ),
                separatorBuilder: (context,index) => Container(
                  width: double.infinity,
                  height: 1.00,
                  color: Colors.grey[300],
                ),
                itemCount: SocialCubit.get(context).users.length
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
      )
    );
  }
}
