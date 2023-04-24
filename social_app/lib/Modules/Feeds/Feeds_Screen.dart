import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Layout/Social_Home/Social_Cubit/Social_Cubit.dart';
import 'package:social_app/Layout/Social_Home/Social_Cubit/Social_States.dart';
import 'package:social_app/Shared/Style/color/colors.dart';

import '../../Models/Post_Model/Post_Model.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state) {},
        builder: (context,state) {
          var cubit = SocialCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.posts.length >0 && SocialCubit.get(context).model != null ,
            builder: (context) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: Card(
                  //     clipBehavior: Clip.antiAliasWithSaveLayer,
                  //     elevation: 10.00,
                  //     margin: const EdgeInsets.all(10),
                  //     child: Stack(
                  //       alignment: AlignmentDirectional.bottomEnd,
                  //       children: [
                  //         const Image(
                  //           image: NetworkImage('https://cdn.searchenginejournal.com/wp-content/uploads/2021/08/top-5-reasons-why-you-need-a-social-media-manager-616015983b3ba-sej-1520x800.png',),
                  //           fit: BoxFit.cover,
                  //           height: 200.00,
                  //           width: double.infinity,
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Text("Communicate with friends",style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.black),),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index) => buildItemCard(cubit.posts[index],context,index),
                    separatorBuilder: (context,index) => const SizedBox(height: 10.00,),
                    itemCount: cubit.posts.length,
                  )
                ],
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
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
                          backgroundImage: NetworkImage(model.image),
                          radius: 25.00,
                        ),
                        const SizedBox(width: 15.00,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children:  [
                                Text(model.name,style: TextStyle(height: 1.3,fontWeight: FontWeight.bold,fontSize: 25.00),),
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
                        // SizedBox(
                        //   height: 20.00,
                        //   child: MaterialButton(
                        //     minWidth: 1.0,
                        //     padding: EdgeInsets.zero,
                        //     onPressed: () {},
                        //     child: const Text("#Software",style: TextStyle(fontSize: 16.00,color: defaultcolor),),
                        //   ),
                        // ),
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
