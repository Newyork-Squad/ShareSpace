abstract class CreateAccountState {}

class CreateAccountInitial extends CreateAccountState {}

class CreateAccountLoading extends CreateAccountState {}

class CreateAccountSuccess extends CreateAccountState {}

class CreateAccountError extends CreateAccountState {
  final String message;

  CreateAccountError(this.message);
}

class CreateAccountValidationError extends CreateAccountState {
  final String? nameError;
  final String? phoneError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;

  CreateAccountValidationError({
    this.nameError,
    this.phoneError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
  });

  bool get hasErrors =>
      nameError != null ||
          phoneError != null ||
          emailError != null ||
          passwordError != null ||
          confirmPasswordError != null;
}

class GenderUpdated extends CreateAccountState {
  final String gender;

  GenderUpdated(this.gender);
}
