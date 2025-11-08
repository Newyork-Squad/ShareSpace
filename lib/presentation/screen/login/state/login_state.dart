part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final String poneNumber;
  final String password;

  LoginLoaded(this.poneNumber, this.password);
}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);
}
