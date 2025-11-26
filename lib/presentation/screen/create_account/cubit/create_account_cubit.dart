import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/remote/error_handler.dart';
import '../../../../domain/usecase/authentication/create_account_usecase.dart';
import 'package:share_space/resources/app_strings.dart';
import 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  final CreateAccountUseCase _createAccountUseCase;

  CreateAccountCubit(this._createAccountUseCase)
      : super(CreateAccountInitial());

  String _fullName = '';
  String _phoneNumber = '';
  String _email = '';
  String _bio = '';
  String? _gender;
  String _password = '';
  String _confirmPassword = '';
  File? _profileImage;

  String? get gender => _gender;

  void updateFullName(String value) => _fullName = value;

  void updatePhoneNumber(String value) => _phoneNumber = value;

  void updateEmail(String value) => _email = value;

  void updateBio(String value) => _bio = value;

  void updateGender(String value) {
    _gender = value;
    emit(GenderUpdated(_gender ?? ''));
  }

  void updatePassword(String value) => _password = value;

  void updateConfirmPassword(String value) => _confirmPassword = value;

  void updateProfileImage(File? file) {
    _profileImage = file;
  }

  bool _validateInputs() {
    String? passwordError;
    String? confirmPasswordError;

    if (_password.isEmpty) {
      passwordError = AppStrings.validationPasswordEmpty;
    }

    if (_confirmPassword.isEmpty) {
      confirmPasswordError = AppStrings.validationConfirmPasswordEmpty;
    } else if (_password != _confirmPassword) {
      confirmPasswordError = AppStrings.createAccountPasswordMismatch;
    }

    if (passwordError != null || confirmPasswordError != null) {
      emit(CreateAccountValidationError(
        passwordError: passwordError,
        confirmPasswordError: confirmPasswordError,
      ));
      return false;
    }

    return true;
  }

  Future<void> createAccount() async {
    if (!_validateInputs()) return;

    emit(CreateAccountLoading());

    try {
      await _createAccountUseCase.execute(
        email: _email.trim(),
        password: _password.trim(),
        name: _fullName.trim(),
        phoneNumber: _phoneNumber.trim(),
        gender: _gender ?? '',
        imageFile: _profileImage,
        bio: _bio.trim().isEmpty ? null : _bio.trim(),
      );

      emit(CreateAccountSuccess());
    } catch (error) {
      String errorMessage = AppStrings.toastUnknownError;

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
