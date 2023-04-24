import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Layout/Social_Home/social_layout.dart';
import 'package:social_app/Modules/Login_Screen/SocialLoginCubit/LoginStates.dart';

import '../../Shared/Components/components.dart';
import 'Register_Cubit/Register_Cubit.dart';
import 'Register_Cubit/Register_States.dart';


class SocialRegisterScreen extends StatelessWidget {
  var UserNameController = TextEditingController();
  var PhoneController = TextEditingController();
  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();
  var FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SocialAppRegisterCubit(),
      child: BlocConsumer<SocialAppRegisterCubit,SocialAppRegisterStates>(
        listener: (context,state) {
          if(state is SocialAppCreateUserSuccessState)
            {
              Navigateto(context,socialLayout());
            }
        },
        builder: (context,state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: FormKey,
                  child: Padding(
                    padding: const EdgeInsets.all(30.00),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Register",style: Theme.of(context).textTheme.headline5,),
                        SizedBox(height: 20.00,),
                        Text("Register now to communicate with your friends",style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.grey),),
                        SizedBox(height: 30.00,),
                        TextFormField(
                          controller: UserNameController,
                          validator: (value) {
                            if(value.isEmpty)
                            {
                              return 'User Name Required';
                            }
                            return null;
                          },
                          onChanged: (value) {},
                          onTap: () {},
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "User Name",
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        SizedBox(height: 30.00,),
                        TextFormField(
                          controller: EmailController,
                          validator: (value) {
                            if(value.isEmpty)
                            {
                              return 'Email Required';
                            }
                            return null;
                          },
                          onChanged: (value) {},
                          onTap: () {},
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Email Address",
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        SizedBox(height: 30.00,),
                        TextFormField(
                          controller: PasswordController,
                          validator: (value) {
                            if(value.isEmpty)
                            {
                              return 'Password Required';
                            }
                            return null;
                          },
                          obscureText: SocialAppRegisterCubit.get(context).IsShown,
                          onChanged: (value) {
                          },
                          onFieldSubmitted: (value)
                          {
                            if(FormKey.currentState.validate())
                              print(EmailController.text);
                            print(PasswordController.text);

                            //SocialAppRegisterCubit.get(context).User_Login(email: EmailController.text, password: PasswordController.text);
                          },
                          onTap: () {},
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                SocialAppRegisterCubit.get(context).ChangeText();
                              },
                              icon: Icon(SocialAppRegisterCubit.get(context).icon,),),
                          ),

                        ),
                        SizedBox(height: 30.00,),
                        TextFormField(
                          controller: PhoneController,
                          validator: (value) {
                            if(value.isEmpty)
                            {
                              return 'Phone Required';
                            }
                            return null;
                          },
                          onChanged: (value) {},
                          onTap: () {},
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ),
                        SizedBox(height: 30.00,),
                        Container(
                            height: 50.00,
                            width: double.infinity,
                            color: Colors.blue,

                            child: MaterialButton(
                              onPressed: ()
                              {
                                if(FormKey.currentState.validate()) {
                                  print(EmailController.text);
                                  print(PasswordController.text);

                                   SocialAppRegisterCubit.get(context).userRegister(
                                       username: UserNameController.text,
                                       email: EmailController.text,
                                       password: PasswordController.text,
                                       phone: PhoneController.text
                                   );
                                }
                              },
                              child: Text("Register"),
                            ),
                          ),
                        SizedBox(height: 30.00,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
