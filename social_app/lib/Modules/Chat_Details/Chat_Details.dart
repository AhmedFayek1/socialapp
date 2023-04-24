import 'package:conditional_builder/conditional_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Layout/Social_Home/Social_Cubit/Social_Cubit.dart';
import 'package:social_app/Layout/Social_Home/Social_Cubit/Social_States.dart';
import 'package:social_app/Models/Chat_Model/Chat_Model.dart';
import 'package:social_app/Models/Social_Model/Social_Model.dart';

import '../../Shared/Components/components.dart';
import '../Friends/Friends.dart';

class ChatDetails extends StatelessWidget {
  CreateUserData userModel;
  
  var messageController = TextEditingController();
  ChatDetails({this.userModel}); 

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context) {
          SocialCubit.get(context).getMessages(receiverID: userModel.uID);
      return BlocConsumer<SocialCubit,SocialStates> (
        listener: (context,state) {},
        builder: (context,state) {
          var cubit = SocialCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(icon: Icon(Icons.arrow_back_ios_new ,size: 20.00,),onPressed: () {Navigator.pop(context);},),
              title: Row(
                children: [
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context).getProfileFriendesPosts(userModel.uID);
                      Navigateto(context, FriendsScreen(userModel));
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(userModel.image),
                      radius: 15.00,
                    ),
                  ),
                  SizedBox(width: 15.00,),
                  Text(userModel.name,style: TextStyle(height: 1.3,fontWeight: FontWeight.bold,fontSize: 25.00),),
                ],

              ),
            ),
            body: Padding(
                  padding: const EdgeInsets.all(20.00),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                            itemBuilder: (context,index) {
                              var message = cubit.messages[index];
                              if(cubit.model.uID == message.senderID)
                                return buildMyMessage(message);
                              else
                                return buildYourMessage(message);
                            },
                            separatorBuilder: (context,index) => SizedBox(height: 10.00,),
                            itemCount: cubit.messages.length,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.00),
                              topLeft: Radius.circular(10.00),
                              bottomLeft: Radius.circular(10.00),
                              bottomRight: Radius.circular(10.00),
                            )
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.00),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    hintText: 'Type your message here ...',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    cubit.getMesageImage();
                                  },
                                  icon: Icon(Icons.image),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if(messageController.text == '' && cubit.messageImage == null) {}
                                    else if(cubit.messageImage != null)
                                    {
                                      cubit.sendImageMessage(
                                          receiverID: userModel.uID,
                                          text: messageController.text,
                                          datetime: DateTime.now().toString()
                                      );
                                      cubit.messageImage = null;
                                    }
                                    else
                                    {
                                      cubit.sendChat(
                                          receiverID: userModel.uID,
                                          text: messageController.text,
                                          datetime: DateTime.now().toString());
                                    }
                                    messageController.text = '';
                                  },
                                  icon: Icon(Icons.send),
                                ),
                              ],
                            )
                          ],
                        ),
                      )

                    ],
                  ),
                ),

          );
        },
      );

    });

  }


  Widget buildMyMessage(ChatModel model) => Align(
    alignment: Alignment.topRight,
    child: Column(
      children: [
        if(model.text != '' || model.image != null)
         Container(
            decoration: BoxDecoration(
                color: Colors.red[300],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.00),
                  topLeft: Radius.circular(10.00),
                  bottomLeft: Radius.circular(10.00),
                )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7.00,horizontal: 10.00),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if(model.text != '')
                   Text(model.text,style: TextStyle(fontSize: 20.00,fontWeight: FontWeight.bold),),
                  if(model.image != null)
                   Image(image: NetworkImage(model.image),),
                  //model.image = null,
                ],
              ),
            )
        ),
        // if(model.image != null)
        //   Container(
        //     width: 140,
        //       height: 140,
        //       decoration: BoxDecoration(
        //           color: Colors.grey[300],
        //           borderRadius: BorderRadius.only(
        //             topRight: Radius.circular(10.00),
        //             topLeft: Radius.circular(10.00),
        //             bottomLeft: Radius.circular(10.00),
        //           )
        //       ),
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 7.00,horizontal: 10.00),
        //         child: Image(image: NetworkImage(model.image),),
        //       )
        //   ),
      ],
    ),
  );

  Widget buildYourMessage(ChatModel model) => Align(
    alignment: Alignment.topLeft,

    child: Column(
      children: [
        if(model.text != '' || model.image != null)
          Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.00),
                    topLeft: Radius.circular(10.00),
                    bottomRight: Radius.circular(10.00),
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.00,horizontal: 10.00),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if(model.text != '')
                      Text(model.text,style: TextStyle(fontSize: 20.00,fontWeight: FontWeight.bold),),
                    if(model.image != null)
                      Image(image: NetworkImage(model.image),),
                  ],
                ),
              )
          ),
        // if(model.image != null)
        //   Container(
        //     width: 140,
        //       height: 140,
        //       decoration: BoxDecoration(
        //           color: Colors.grey[300],
        //           borderRadius: BorderRadius.only(
        //             topRight: Radius.circular(10.00),
        //             topLeft: Radius.circular(10.00),
        //             bottomLeft: Radius.circular(10.00),
        //           )
        //       ),
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 7.00,horizontal: 10.00),
        //         child: Image(image: NetworkImage(model.image),),
        //       )
        //   ),
      ],
    ),  );


}
