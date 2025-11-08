import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/domain/usecase/authentication/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(LoginInitial());

  Future<void> login(String phoneNumber, String password) async {
    emit(LoginLoading());
    try {
      await _loginUseCase(phoneNumber, password);
      emit(LoginLoaded(phoneNumber, password));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}