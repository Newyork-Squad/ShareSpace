import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../design_system/theme/app_theme.dart';
import '../../design_system/widget/custom_top_snackbar.dart';
import '../create_account/create_account_screen.dart' show showCustomTopSnackBar;
import 'cubit/otp_verification_cubit.dart';
import 'cubit/otp_verification_state.dart';
import 'widgets/otp_header.dart';
import 'widgets/otp_input_fields.dart';
import 'widgets/otp_confirm_button.dart';
import 'widgets/otp_resend_text.dart';

class OtpVerificationArgs {
  final String phoneNumber;

  const OtpVerificationArgs({required this.phoneNumber});
}

class OtpVerificationScreen extends StatelessWidget {
  final String phoneNumber;

  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtpVerificationCubit(),
      child: _OtpVerificationView(phoneNumber: phoneNumber),
    );
  }
}

class _OtpVerificationView extends StatefulWidget {
  final String phoneNumber;

  const _OtpVerificationView({required this.phoneNumber});

  @override
  State<_OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<_OtpVerificationView> {
  final GlobalKey<OtpInputFieldsState> _otpFieldsKey =
      GlobalKey<OtpInputFieldsState>();

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final viewInsets = MediaQuery.of(context).viewInsets;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.colors.surfaceLow,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/login_screen_shapes.png',
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: BlocConsumer<OtpVerificationCubit, OtpVerificationState>(
                listener: (context, state) {
                  if (state is OtpVerificationSuccess) {
                    CustomTopSnackBar.show(
                      context,
                      title: 'Success',
                      message: 'Account verified successfully!',
                      isError: false,
                    );
                  } else if (state is OtpVerificationError) {
                    CustomTopSnackBar.show(
                      context,
                      title: 'Error',
                      message: state.message,
                      isError: true,
                    );
                  } else if (state is OtpResendSuccess) {
                    CustomTopSnackBar.show(
                      context,
                      title: 'Success',
                      message: 'A new code has been sent.',
                      isError: false,
                    );
                    _otpFieldsKey.currentState?.clear();
                  }
                },
                builder: (context, state) {
                  final cubit = context.read<OtpVerificationCubit>();
                  final isLoading = state is OtpVerificationLoading;
                  final isComplete = state is OtpCodeComplete;

                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.fromLTRB(
                            24,
                            48,
                            24,
                            24 + viewInsets.bottom,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 32),
                              OtpHeader(phoneNumber: widget.phoneNumber),
                              const SizedBox(height: 48),
                              OtpInputFields(
                                key: _otpFieldsKey,
                                onCompleted: cubit.updateOtpCode,
                                onChanged: cubit.onCodeChanged,
                              ),
                              const SizedBox(height: 48),
                            ],
                          ),
                        ),
                      ),
                      AnimatedPadding(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                        padding: EdgeInsets.fromLTRB(
                          24,
                          0,
                          24,
                          24 + viewInsets.bottom,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            OtpConfirmButton(
                              isEnabled: isComplete && !isLoading,
                              isLoading: isLoading,
                              onPressed: () {
                                if (isComplete && !isLoading) {
                                  cubit.verifyOtp();
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            OtpResendText(onResend: cubit.resendOtp),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

