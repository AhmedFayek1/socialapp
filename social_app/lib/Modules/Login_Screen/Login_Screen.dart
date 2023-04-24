import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Layout/Social_Home/social_layout.dart';
import 'package:social_app/Modules/Login_Screen/SocialLoginCubit/LoginStates.dart';
import 'package:social_app/Modules/Register_Screen/Register_Screen.dart';
import 'package:social_app/Shared/Constants/constants.dart';

import '../../Shared/Components/components.dart';
import 'SocialLoginCubit/LoginCubit.dart';
import 'package:social_app/Shared/Network/remote/Dio_Helber.dart';
import 'package:social_app/Shared/Network/local/Cache_Helper.dart';

class SocialLoginScreen extends StatelessWidget {
  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();
  var FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SocialAppCubit(),
      child: BlocConsumer<SocialAppCubit,SocialAppStates>(
        listener: (context,state) {
          if(state is SocialAppLoginErrorState)
            {
              ShowToast(
                  message: state.error,
                  state: ToastStates.ERROR,
              );
            }

          if(state is SocialAppLoginSuccessState)
            {
              cache_helper.SaveData(
                  key: 'uID',
                  value: state.uID
              ).then((value)
              {
                NavigatetoFinish(
                  context,
                  socialLayout()
                );
              });

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
                        Text("Login",style: Theme.of(context).textTheme.headline5,),
                        SizedBox(height: 20.00,),
                        Text("Login now to communicate with your friends",style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.grey),),
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
                          obscureText: SocialAppCubit.get(context).IsShown,
                          onChanged: (value) {
                          },
                          onFieldSubmitted: (value)
                          {
                            if(FormKey.currentState.validate())
                              print(EmailController.text);
                            print(PasswordController.text);

                            //SocialAppCubit.get(context).User_Login(email: EmailController.text, password: PasswordController.text);
                          },
                          onTap: () {},
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                SocialAppCubit.get(context).ChangeText();
                              },
                              icon: Icon(SocialAppCubit.get(context).icon,),),
                          ),

                        ),
                        SizedBox(height: 30.00,),
                        ConditionalBuilder(
                          condition: state != SocialAppLoginLoadingState,
                          builder: (context) => Container(
                            height: 50.00,
                            width: double.infinity,
                            color: Colors.blue,

                            child: MaterialButton(
                              onPressed: ()
                              {
                                if(FormKey.currentState.validate()) {
                                  SocialAppCubit.get(context).userLogin(
                                      email: EmailController.text,
                                      password: PasswordController.text
                                  );
                                }
                              },
                              child: Text("LOGIN"),
                            ),
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 30.00,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Don't have account?"),
                            SizedBox(width: 20.00,),
                            TextButton(
                                onPressed: () {
                                  Navigateto(context,SocialRegisterScreen());
                                },
                                child: Text("REGISTER")
                            ),
                          ],
                        )
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
