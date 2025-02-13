import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';



class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    // 🔹 LOGIN EVENT
    on<LoginuserEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        final url = Uri.parse("https://dummyjson.com/auth/login");
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "username": 'emilys',
            "password": 'emilyspass',
          }),
        );

        final responseData = json.decode(response.body);
        print("Response: $responseData");

        if (response.statusCode == 200 && responseData['accessToken'] != null) {
          // 🔹 Store Token in SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('accessToken', responseData['accessToken']);
        
          emit(LoginSuccess(token: responseData['accessToken']));
        } else {
          emit(AuthenticatedError(error: "Invalid username or password"));
        }
      } catch (e) {
        emit(AuthenticatedError(error: "Something went wrong!"));
      }
    });

    // 🔹 LOGOUT EVENT
    on<LogoutUserEvent>((event, emit) async {
      emit(LoginLoading());
      await Future.delayed(Duration(seconds: 1));

      // 🔹 Remove Token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('accessToken');

      emit(LogoutSuccess());
    });

    // 🔹 CHECK LOGIN STATUS EVENT
    on<CheckLoginStatusevent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      if (token != null && token.isNotEmpty) {
        emit(LoginSuccess(token: token));
      } else {
        emit(LoginInitial());
      }
    });
  }
}
