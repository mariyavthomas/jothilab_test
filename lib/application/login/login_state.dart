part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginLoading extends LoginState{}

class Authenticated extends LoginState{
 final  user;
  Authenticated(this.user);
}

class AuthenticatedError extends LoginState{
  final String error;
  AuthenticatedError({required this.error});
}
class LoginSuccess extends LoginState {
  final String token;
  LoginSuccess({required this.token});
}
class LogoutSuccess extends LoginState {} 