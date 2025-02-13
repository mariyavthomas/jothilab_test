// ignore_for_file: depend_on_referenced_packages


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jothilabproject/application/login/login_bloc.dart';
import 'package:jothilabproject/application/product/product_bloc.dart';
import 'package:jothilabproject/presention/home_page/home_page.dart';
import 'package:jothilabproject/presention/login_screen/custom_widgets/field.dart';
import 'package:jothilabproject/utils/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class LoginButtons {
  static signIn(BuildContext context, GlobalKey<FormState> formkey) {
    return InkResponse(
      onTap: () {
        if (formkey.currentState!.validate()) {
          BlocProvider.of<LoginBloc>(context).add(LoginuserEvent(
              username: usernamecontroller.text.trim(),
              password: passwordController.text.trim()));
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
         
        }
        
      },
      child: Container(
        height: 50,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: CustomColor.blackColor(),
        ),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginLoading) {
              return Align(
                  alignment: Alignment.center,
                  child: LoadingAnimationWidget.horizontalRotatingDots(
                    color: CustomColor.whiteColor(),
                    size: 50,
                  ));
            } else {
              return Align(
                alignment: Alignment.center,
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: CustomColor.whiteColor(),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  static Widget newaccountcreate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 130),
      child: Row(
        children: [
          Text('New here?',style: TextStyle(color: Colors.white),),
          TextButton(onPressed: (){
            
          }, child: Text('Register Now',style: TextStyle(color: Colors.blue),))
        ],
      ),
    );
  }
}