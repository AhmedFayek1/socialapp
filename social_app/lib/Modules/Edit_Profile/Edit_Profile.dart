import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Layout/Social_Home/Social_Cubit/Social_Cubit.dart';
import 'package:social_app/Layout/Social_Home/Social_Cubit/Social_States.dart';
import 'package:social_app/Shared/Style/color/colors.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
       listener: (context,state) {},
      builder: (context,state) {

        var userModel = SocialCubit.get(context).model;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        // ignore: non_constant_identifier_names
        var nameController = TextEditingController();
        // ignore: non_constant_identifier_names
        var bioController = TextEditingController();
        // ignore: non_constant_identifier_names
        var emailController = TextEditingController();
        // ignore: non_constant_identifier_names
        var phoneController = TextEditingController();

        nameController.text = userModel.name;
        bioController.text = userModel.bio;
        emailController.text = userModel.email;
        phoneController.text = userModel.phone;

        return Scaffold(
             appBar: AppBar(
               leading: IconButton(
                   onPressed: () {
                     Navigator.pop(context);
                   },
                   icon: const Icon(Icons.arrow_back_ios_new_outlined)
               ),
               title: const Text("Edit Profile"),
               actions: [
                 TextButton(
                     onPressed: () {
                       if(SocialCubit.get(context).profileImage != null)
                         SocialCubit.get(context).UplodeProfileImage(name: nameController.text, email: emailController.text, phone: phoneController.text, bio: bioController.text);
                       if(SocialCubit.get(context).coverImage != null)
                         SocialCubit.get(context).UplodeCoverImage(name: nameController.text, email: emailController.text, phone: phoneController.text, bio: bioController.text);
                       else
                         SocialCubit.get(context).UpdateUserData(name: nameController.text, email: emailController.text,  phone: phoneController.text, bio: bioController.text,image: userModel.image,cover: userModel.cover);
                    Navigator.pop(context);
                     },
                     child: const Text("UPDATE",style: TextStyle(color: defaultcolor),)
                 )
               ],
             ),


             body: SingleChildScrollView(
               child: Column(
                   children: [
                     if(state is SocialLoadingState) const LinearProgressIndicator(),
                     if(state is SocialLoadingState) const SizedBox(height: 10.00,),
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
                                       height: 140.00,
                                       decoration: BoxDecoration(
                                         borderRadius: const BorderRadius.only(
                                             topLeft: Radius.circular(4.00),
                                             topRight: Radius.circular(4.00)
                                         ),
                                         image: DecorationImage(
                                             image: coverImage == null ?NetworkImage(userModel.cover) : FileImage(coverImage),
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
                                               backgroundColor: defaultcolor,
                                               child: Icon(Icons.camera_alt_outlined)
                                           ),
                                           onPressed: () {
                                             SocialCubit.get(context).getCoverImage();
                                           },),
                                       ),
                                     ),
                                   ],
                                 )
                               ),
                             ),
                             Stack(
                               alignment: AlignmentDirectional.bottomEnd,
                               children: [
                                 CircleAvatar(
                                   radius: 64,
                                   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                   child: CircleAvatar(
                                     backgroundImage: profileImage == null ? NetworkImage(userModel.image) : FileImage(profileImage),
                                     radius: 60.00,
                                   ),
                                 ),
                                 IconButton(
                                   icon: const CircleAvatar(
                                       radius: 17,
                                       backgroundColor: defaultcolor,
                                       child: Icon(Icons.camera_alt_outlined)
                                   ),
                                   onPressed: () {
                                     SocialCubit.get(context).getProfileImage();
                                   },),

                               ],
                             )
                           ]
                       ),
                     ),
                     const SizedBox(height: 20.00,),
                     TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if(value.isEmpty) {
                          return 'Required';
                        }
                        else
                          {
                            return null;
                          }
                      },
                      onTap: () {},
                      decoration: const InputDecoration(
                        label: Text("Name"),
                        //labelText: userModel.name,
                        prefixIcon: Icon(Icons.person),
                      ),

                     ),
                     const SizedBox(height: 10.00,),
                     TextFormField(
                        controller: bioController,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Required';
                          }
                          else
                          {
                            return null;
                          }
                        },
                        onTap: () {},
                        decoration: const InputDecoration(
                          label: Text("Bio"),
                          //labelText: userModel.bio,
                          prefixIcon: Icon(Icons.info_outline),
                        ),


                      ),
                     const SizedBox(height: 10.00,),
                     TextFormField(
                       controller: emailController,
                       validator: (value) {
                         if(value.isEmpty) {
                           return 'Required';
                         }
                         else
                         {
                           return null;
                         }
                       },
                       onTap: () {},
                       decoration: const InputDecoration(
                         label: Text("Email Address"),
                         //labelText: userModel.name,
                         prefixIcon: Icon(Icons.email),
                       ),

                     ),
                     const SizedBox(height: 10.00,),
                     TextFormField(
                       controller: phoneController,
                       validator: (value) {
                         if(value.isEmpty) {
                           return 'Required';
                         }
                         else
                         {
                           return null;
                         }
                       },
                       onTap: () {},
                       decoration: const InputDecoration(
                         label: Text("Phone Number"),
                         //labelText: userModel.bio,
                         prefixIcon: Icon(Icons.phone),
                       ),


                     )
                   ],
                 ),
             ),
           );

      }
    );
  }
}
