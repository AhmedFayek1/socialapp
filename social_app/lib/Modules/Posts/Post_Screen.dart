import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Layout/Social_Home/Social_Cubit/Social_States.dart';
import 'package:social_app/Shared/Components/components.dart';

import '../../Layout/Social_Home/Social_Cubit/Social_Cubit.dart';
import '../../Shared/Style/color/colors.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state) {},
      builder: (context,state) {
        var cubit = SocialCubit.get(context);
        var postController = TextEditingController();

        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () { Navigator.pop(context);},
                  icon: Icon(Icons.arrow_back_ios_new,size: 20.00,)
              ),
              title: Text("Add Post"),
              actions: [
                TextButton(
                    onPressed: () {
                      if(cubit.postimage != null)
                        {
                          cubit.uploadPostImage(text: postController.text, datetime: DateTime.now().toString());
                          Navigator.pop(context);
                        }
                      else
                        {
                          cubit.createPost(datetime: DateTime.now().toString(), text: postController.text,);
                          Navigator.pop(context);
                        }
                    },
                    child: const Text("POST",style: TextStyle(color: defaultcolor),)
                )
              ],        ),
            body: Padding(
              padding: const EdgeInsets.all(20.00),
              child: Column(
                children: [
                  if(state is SocialUploadPostLoadingState)
                    LinearProgressIndicator(),
                  if(state is SocialUploadPostLoadingState)
                    SizedBox(height: 10.00,),
                  Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(SocialCubit.get(context).model.image),
                          radius: 25.00,
                        ),
                        SizedBox(width: 15.00,),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(SocialCubit.get(context).model.name, style: TextStyle(height: 1.3,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.00),)
                              ]
                          ),
                        )
                      ]
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: postController,
                      decoration: InputDecoration(
                        hintText: 'What is on your mind ...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if(cubit.postimage != null)
                    Container(
                    height: 190.00,
                    child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.00),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 150.00,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(5.00)),
                                        image: DecorationImage(
                                            image: FileImage(cubit.postimage),
                                            fit:BoxFit.cover
                                        ),

                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.00),
                                        child: IconButton(
                                          icon: const CircleAvatar(
                                              radius: 17,
                                              child: Icon(Icons.highlight_remove)
                                          ),
                                          onPressed: () {
                                            cubit.RemovePostImage();
                                          },),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ]
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              cubit.getpostImage();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              Icon(Icons.image),
                              SizedBox(width: 5.00,),
                              Text("Add photo"),
                            ],)
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              Text("# tags"),
                            ],)
                        ),
                      )

                    ],
                  )
                ],
              ),
            )
        );
      },
    );
  }
}
