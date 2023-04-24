import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Layout/Social_Home/Social_Cubit/Social_Cubit.dart';
import 'package:social_app/Layout/Social_Home/Social_Cubit/Social_States.dart';
import '../../Models/Post_Model/Post_Model.dart';
import '../../Shared/Style/color/colors.dart';

class FriendsScreen extends StatelessWidget {

  final userModel;
  FriendsScreen(this.userModel);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>
      (
      listener: (context,state) {},
      builder: (context,state) {
        var cubit = SocialCubit.get(context);
        //var userModel = SocialCubit.get(context).model;
        return  Material(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 190.00,
                    child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,

                        children: [
                          Align(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.00),
                              child: Container(
                                width: double.infinity,
                                height: 140.00,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.00),
                                      topRight: Radius.circular(4.00)
                                  ),
                                  image: DecorationImage(
                                      image:NetworkImage(userModel.cover),
                                      fit:BoxFit.cover
                                  ),

                                ),
                              ),
                            ),
                            alignment: AlignmentDirectional.topCenter,
                          ),
                          CircleAvatar(
                            radius: 64,
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(userModel.image),
                              radius: 60.00,
                            ),
                          ),
                        ]
                    ),
                  ),
                  SizedBox(height: 5.00,),
                  Text(userModel.name, style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5.00,),
                  Text(userModel.bio, style: Theme.of(context).textTheme.caption.copyWith(fontSize: 20.00),),
                  SizedBox(height: 40.00),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child:
                            InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text("100",style: TextStyle(fontSize: 20.00,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5.00,),
                                  Text("Posts",style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.00),)

                                ],
                              ),
                            ),),
                          Expanded(
                            child:
                            InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text("265",style: TextStyle(fontSize: 20.00,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5.00,),
                                  Text("Photos",style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.00),)

                                ],
                              ),
                            ),),
                          Expanded(
                            child:
                            InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text("10k",style: TextStyle(fontSize: 20.00,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5.00,),
                                  Text("Followers",style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.00),)
                                ],
                              ),
                            ),),
                          Expanded(
                            child:
                            InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text("64",style: TextStyle(fontSize: 20.00,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5.00,),
                                  Text("Following",style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.00),)

                                ],
                              ),
                            ),),

                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          child: OutlinedButton(
                            onPressed: ()  {
                            },
                            child: Text("Follow",style: Theme.of(context).textTheme.bodyText1.copyWith(color: defaultcolor),),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.00,),
                      Container(
                        height: 40.00,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Icon(Icons.menu,),
                        ),
                      ),
                    ],
                  ),
                  ConditionalBuilder(
                    condition: cubit.profileFriendesPosts.length >0 && SocialCubit.get(context).model != null ,
                    builder: (context) => SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index) => buildItemCard(cubit.profileFriendesPosts[index],context,index),
                            separatorBuilder: (context,index) => const SizedBox(height: 10.00,),
                            itemCount: cubit.profileFriendesPosts.length,
                          )
                        ],
                      ),
                    ),
                    fallback: (context) => Center(child: CircularProgressIndicator()),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildItemCard(PostModel model,context,index)
  {

    return Container(
      width: double.infinity,
      child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 10.00,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(userModel.image),
                        radius: 25.00,
                      ),
                      const SizedBox(width: 15.00,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children:  [
                              Text(userModel.name,style: TextStyle(height: 1.3,fontWeight: FontWeight.bold,fontSize: 25.00),),
                              SizedBox(width: 5.00,),
                              Icon(Icons.check_circle,color: defaultcolor,size: 20.00,)
                            ],
                          ),
                          Text(model.datetime, style: Theme.of(context).textTheme.caption.copyWith(height: 1.3, fontSize: 15),),
                        ],
                      ),
                      const Spacer(),
                      IconButton(icon: const Icon(Icons.more_horiz_outlined), onPressed: () {  },),
                    ],

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.00),
                  child: Container(
                    width: double.infinity,
                    height: 1.00,
                    color: Colors.grey[300],
                  ),
                ),
                Text(model.text,style: Theme.of(context).textTheme.subtitle1,),
                Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      SizedBox(
                        height: 20.00,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text("#Software",style: TextStyle(fontSize: 16.00,color: defaultcolor),),
                        ),
                      ),
                      SizedBox(
                        height: 20.00,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text("#Software",style: TextStyle(fontSize: 16.00,color: defaultcolor),),
                        ),
                      ),
                      SizedBox(
                        height: 20.00,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text("#Software",style: TextStyle(fontSize: 16.00,color: defaultcolor),),
                        ),
                      ),
                      SizedBox(
                        height: 20.00,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text("#Software",style: TextStyle(fontSize: 16.00,color: defaultcolor),),
                        ),
                      ),
                      SizedBox(
                        height: 20.00,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text("#Software",style: TextStyle(fontSize: 16.00,color: defaultcolor),),
                        ),
                      ),
                      SizedBox(
                        height: 20.00,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text("#Software",style: TextStyle(fontSize: 16.00,color: defaultcolor),),
                        ),
                      ),
                      SizedBox(
                        height: 20.00,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text("#Software",style: TextStyle(fontSize: 16.00,color: defaultcolor),),
                        ),
                      ),
                      SizedBox(
                        height: 20.00,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text("#Software",style: TextStyle(fontSize: 16.00,color: defaultcolor),),
                        ),
                      ),
                      SizedBox(
                        height: 20.00,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text("#Software",style: TextStyle(fontSize: 16.00,color: defaultcolor),),
                        ),
                      ),



                    ],
                  ),
                ),
                if(model.postImage != ''  )
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 15),
                    child: Container(
                      width: double.infinity,
                      height: 140.00,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.00),
                        image:  DecorationImage(
                            image:NetworkImage(model.postImage),
                            fit:BoxFit.cover
                        ),

                      ),
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(top: 5),
                          child: Row(
                            children:  [
                              Icon(Icons.favorite,color: Colors.red,size: 17,),
                              SizedBox(width: 5.00,),
                              Text('${SocialCubit.get(context).likes[index]}'),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.00),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Icon(Icons.chat_bubble,color: Colors.amber,size: 17,),
                              SizedBox(width: 5.00,),
                              Text("0 Comment"),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.00),
                  child: Container(
                    width: double.infinity,
                    height: 1.00,
                    color: Colors.grey[300],
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},

                      child: Expanded(
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(SocialCubit.get(context).model.image),
                              radius: 15.00,
                            ),
                            const SizedBox(width: 10.00,),
                            Text("Write a Comment ...",style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.00),),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.00),
                        child: Row(
                          children:  [
                            Icon(Icons.favorite,color: Colors.red,size: 17),
                            SizedBox(width: 5.00,),
                            Text("Like"),
                          ],
                        ),
                      ),
                      onTap: () {
                        SocialCubit.get(context).likePosts(SocialCubit.get(context).id[index]);
                      },
                    ),

                  ],
                )


              ],
            ),
          )
      ),

    );

  }
}
