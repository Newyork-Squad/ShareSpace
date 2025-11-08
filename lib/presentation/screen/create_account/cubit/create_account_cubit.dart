import 'package:flutter_bloc/flutter_bloc.dart';
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

  String get fullName => _fullName;
  String get phoneNumber => _phoneNumber;
  String get email => _email;
  String get bio => _bio;
  String get gender => _gender;
  String get password => _password;
  String get confirmPassword => _confirmPassword;

  void updateFullName(String value) {
    _fullName = value;
  }

  void updatePhoneNumber(String value) {
    _phoneNumber = value;
  }

  void updateEmail(String value) {
    _email = value;
  }

  void updateBio(String value) {
    _bio = value;
  }

  void updateGender(String value) {
    _gender = value;
    emit(CreateAccountInitial());
  }

  void updatePassword(String value) {
    _password = value;
  }

  void updateConfirmPassword(String value) {
    _confirmPassword = value;
  }

  String? _validateFullName() {
    if (_fullName.trim().isEmpty) {
      return 'Full name is required';
    }
    if (_fullName.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  String? _validatePhoneNumber() {
    if (_phoneNumber.trim().isEmpty) {
      return 'Phone number is required';
    }

    if (!_phoneNumber.trim().startsWith('+')) {
      return 'Phone number must include country code';
    }

    String cleanPhone = _phoneNumber.replaceAll(RegExp(r'^\+\d{1,4}'), '').trim();
    if (cleanPhone.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? _validateEmail() {
    if (_email.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_email.trim())) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword() {
    if (_password.isEmpty) {
      return 'Password is required';
    }
    if (_password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword() {
    if (_confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    if (_password != _confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  bool _validateAllFields() {
    final nameError = _validateFullName();
    final phoneError = _validatePhoneNumber();
    final emailError = _validateEmail();
    final passwordError = _validatePassword();
    final confirmPasswordError = _validateConfirmPassword();

    if (nameError != null ||
        phoneError != null ||
        emailError != null ||
        passwordError != null ||
        confirmPasswordError != null) {
      emit(CreateAccountValidationError(
        nameError: nameError,
        phoneError: phoneError,
        emailError: emailError,
        passwordError: passwordError,
        confirmPasswordError: confirmPasswordError,
      ));
      return false;
    }
    return true;
  }

  Future<void> createAccount({String? imageUrl}) async {
    if (!_validateAllFields()) {
      return;
    }

    emit(CreateAccountLoading());

    try {
      final formattedPhone = _phoneNumber.trim();

      await _createAccountUseCase.execute(
        email: _email.trim(),
        password: _password,
        name: _fullName.trim(),
        phoneNumber: formattedPhone,
        gender: _gender,
        imageUrl: imageUrl,
        bio: _bio.trim().isEmpty ? null : _bio.trim(),
      );

      emit(CreateAccountSuccess());
    } catch (e) {
      emit(CreateAccountError(e.toString()));
    }
  }

  void resetState() {
    emit(CreateAccountInitial());
  }

  void clearFields() {
    _fullName = '';
    _phoneNumber = '';
    _email = '';
    _bio = '';
    _gender = 'Male';
    _password = '';
    _confirmPassword = '';
    emit(CreateAccountInitial());
  }
}