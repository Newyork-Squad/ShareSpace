import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecase/User/getUserDetailsUseCase.dart';
import '../../../../domain/usecase/authentication/logout_usecase.dart';
import 'my_account_state.dart';

class MyAccountCubit extends Cubit<MyAccountState> {
  final GetUserDetailsUseCase _getUserDetailsUseCase;
  final LogoutUseCase _logoutUseCase;

  MyAccountCubit(this._getUserDetailsUseCase,this._logoutUseCase) : super(AccountInitial());

  Future<void> getUserDetails() async {
    emit(AccountLoading());
    try {
      final user = await _getUserDetailsUseCase.call();
      emit(AccountLoaded(user));
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AccountLoading());
    try {
      await _logoutUseCase.call();
      emit(AccountLoggedOut());
    } catch (e) {
      emit(AccountError('Logout failed: $e'));
    }
  }
}
