part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final String phoneNumber;
  final String password;

  LoginLoaded(this.phoneNumber, this.password);
}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);
}
