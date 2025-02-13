// ignore_for_file: unused_element, use_super_parameters, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:jothilabproject/utils/custom_textform.dart';
import 'package:jothilabproject/utils/validator.dart';

final TextEditingController usernamecontroller = TextEditingController();
final TextEditingController passwordController = TextEditingController();
@override
void dispose() {
  usernamecontroller.dispose();
  passwordController.dispose();
}

bool obtext = true;

class LoginFields {
  static Widget usernameFields() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextFormField(
        controller: usernamecontroller,
        hintText: 'Enter your email or phone',
        keyboardType: TextInputType.emailAddress,
        validator: (value) => Validator().usernameValidator(value),
        labelText: 'Email',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  static Widget passwordFields() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextFormField(
        obscureText: obtext,
        controller: passwordController,
        labelText: 'password',
        style: TextStyle(color: Colors.black),
        hintText: 'Enter your password',
        keyboardType: TextInputType.visiblePassword,
        validator: (value) => Validator().passwordValidator(value),
      ),
    );
  }
}
