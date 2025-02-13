part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginuserEvent extends LoginEvent{
  final String username;
  final String password;
  LoginuserEvent({required this.username,required this.password});
}
class CheckLoginStatusevent extends LoginEvent{}
class LogoutUserEvent extends LoginEvent {} // New logout event