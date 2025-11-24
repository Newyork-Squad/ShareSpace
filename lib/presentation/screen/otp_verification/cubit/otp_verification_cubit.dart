import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_verification_state.dart';

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  OtpVerificationCubit() : super(OtpVerificationInitial());

  String _otpCode = '';

  void updateOtpCode(String code) {
    _otpCode = code;
    if (code.length == 6) {
      emit(OtpCodeComplete(code));
    }
  }

  void onCodeChanged(String code) {
    _otpCode = code;
    if (code.length < 6) {
      emit(OtpVerificationInitial());
    }
  }

  Future<void> verifyOtp() async {
    if (_otpCode.length != 6) {
      emit(OtpVerificationError('Please enter complete verification code'));
      return;
    }

    emit(OtpVerificationLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));

      emit(OtpVerificationSuccess());
    } catch (e) {
      emit(OtpVerificationError('Verification failed. Please try again.'));
    }
  }

  Future<void> resendOtp() async {
    emit(OtpVerificationLoading());

    try {
      await Future.delayed(const Duration(seconds: 1));

      emit(OtpResendSuccess());
      emit(OtpVerificationInitial());
    } catch (e) {
      emit(OtpVerificationError('Failed to resend code. Please try again.'));
    }
  }
}


