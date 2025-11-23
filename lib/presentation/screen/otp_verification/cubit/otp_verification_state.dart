abstract class OtpVerificationState {}

class OtpVerificationInitial extends OtpVerificationState {}

class OtpVerificationLoading extends OtpVerificationState {}

class OtpCodeComplete extends OtpVerificationState {
  final String code;

  OtpCodeComplete(this.code);
}

class OtpVerificationSuccess extends OtpVerificationState {}

class OtpVerificationError extends OtpVerificationState {
  final String message;

  OtpVerificationError(this.message);
}

class OtpResendSuccess extends OtpVerificationState {}


