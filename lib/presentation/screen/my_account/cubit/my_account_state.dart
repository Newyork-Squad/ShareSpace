import '../../../../domain/entity/user.dart';

abstract class MyAccountState {}

class AccountInitial extends MyAccountState {}

class AccountLoading extends MyAccountState {}

class AccountLoaded extends MyAccountState {
  final User user;

  AccountLoaded(this.user);
}

class AccountError extends MyAccountState {
  final String message;

  AccountError(this.message);
}

class AccountLoggedOut extends MyAccountState {}
