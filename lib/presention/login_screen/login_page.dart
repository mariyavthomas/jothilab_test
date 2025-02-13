// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jothilabproject/application/login/login_bloc.dart';
import 'package:jothilabproject/presention/login_screen/custom_widgets/button.dart';
import 'package:jothilabproject/presention/login_screen/custom_widgets/field.dart';
import 'package:jothilabproject/utils/divider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          _showSnackBar(context, 'Successfully Logged In', Colors.green);
        } else if (state is AuthenticatedError) {
          _showErrorDialog(context, state.error.toString());
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: _buildBackgroundContainer(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundContainer() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/shoppinpic3-removebg-preview.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            _buildGreetingText(),
            const SizedBox(height: 20),
            _buildLoginFields(),
            _buildButtonsSection(),
            const SizedBox(height: 220),
          ],
        ),
      ),
    );
  }

  Widget _buildGreetingText() {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello",
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          Text(
            "There.",
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          LoginFields.usernameFields(),
          LoginFields.passwordFields(),
        ],
      ),
    );
  }

  Widget _buildButtonsSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        LoginButtons.signIn(context, _formKey),
        const SizedBox(height: 20),
        Dividers.line(),
        LoginButtons.newaccountcreate(context),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: color),
      );
    });
  }

  void _showErrorDialog(BuildContext context, String error) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(error),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }
}
