import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/remote/error_handler.dart';
import '../../../../domain/usecase/authentication/create_account_usecase.dart';
import 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  final CreateAccountUseCase _createAccountUseCase;

  CreateAccountCubit(this._createAccountUseCase)
    : super(CreateAccountInitial());

  String _fullName = '';
  String _phoneNumber = '';
  String _email = '';
  String _bio = '';
  String _gender = 'Male';
  String _password = '';
  String _confirmPassword = '';

  String get gender => _gender;

  void updateFullName(String value) => _fullName = value;

  void updatePhoneNumber(String value) => _phoneNumber = value;

  void updateEmail(String value) => _email = value;

  void updateBio(String value) => _bio = value;

  void updateGender(String value) {
    _gender = value;
    emit(GenderUpdated(_gender));
  }

  void updatePassword(String value) => _password = value;

  void updateConfirmPassword(String value) => _confirmPassword = value;

  Future<void> createAccount({String? imageUrl}) async {
    emit(CreateAccountLoading());

    try {
      await _createAccountUseCase.execute(
        email: _email.trim(),
        password: _password.trim(),
        name: _fullName.trim(),
        phoneNumber: _phoneNumber.trim(),
        gender: _gender,
        imageUrl: imageUrl,
        bio: _bio.trim().isEmpty ? null : _bio.trim(),
      );

      emit(CreateAccountSuccess());
    } catch (error) {
      String errorMessage = 'An unknown error occurred. Please try again.';

      if (error is DioException) {
        final handledError = handleError(error);
        errorMessage = handledError.toString().replaceAll('Exception: ', '');
      } else if (error is Exception) {
        errorMessage = error.toString().replaceAll('Exception: ', '');
      }

      emit(CreateAccountError(errorMessage));
    }
  }

  void resetState() => emit(CreateAccountInitial());
}
