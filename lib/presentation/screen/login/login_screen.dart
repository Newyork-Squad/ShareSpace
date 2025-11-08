import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/di/injection.dart';
import 'package:share_space/presentation/design_system/colors/app_color.dart';
import 'package:share_space/presentation/design_system/typography/app_typography.dart';
import 'package:share_space/presentation/routes/routes.dart';
import 'package:share_space/presentation/screen/login/state/login_cubit.dart';

import 'login_widget/app_logo.dart';
import 'login_widget/login_button.dart';
import 'login_widget/password_input_field.dart';
import 'login_widget/phone_input_field.dart';
import 'login_widget/register_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final ValueNotifier<bool> isFormValid = ValueNotifier(false);

  void _validateForm() {
    final valid =
        phoneController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty;
    if (isFormValid.value != valid) {
      isFormValid.value = valid;
    }
  }

  @override
  void initState() {
    super.initState();
    phoneController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    isFormValid.dispose();
    super.dispose();
  }

  void _handleLogin(BuildContext context) {
    final phoneNumber = phoneController.text.trim();
    final password = passwordController.text.trim();
    context.read<LoginCubit>().login(phoneNumber, password);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoaded) {
            Navigator.pushReplacementNamed(context, Routes.appNavigationBar);
          } else if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.light.surfaceLow,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
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
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const AppLogo(),
                              const SizedBox(height: 24),
                              Text(
                                "Welcome Back",
                                style: AppTypography().textTheme.titleMedium
                                    ?.copyWith(color: AppColors.light.title),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Please enter your phone number and password to access your booking",
                                textAlign: TextAlign.center,
                                style: AppTypography().textTheme.bodyMedium
                                    ?.copyWith(color: AppColors.light.body),
                              ),
                              const SizedBox(height: 32),
                              PhoneInputField(controller: phoneController),
                              const SizedBox(height: 16),
                              PasswordInputField(
                                controller: passwordController,
                              ),
                            ],
                          ),
                        ),
                      ),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          final isLoading = state is LoginLoading;

                          return ValueListenableBuilder<bool>(
                            valueListenable: isFormValid,
                            builder: (context, valid, _) {
                              return Container(
                                color: AppColors.light.surfaceLow.withValues(
                                  alpha: 0.9,
                                ),
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  bottom: 12,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    LoginButton(
                                      isEnabled: valid && !isLoading,
                                      onPressed: isLoading
                                          ? null
                                          : () => _handleLogin(context),
                                    ),
                                    if (isLoading) ...[
                                      const SizedBox(height: 8),
                                      const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    ],
                                    const SizedBox(height: 12),
                                    RegisterText(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.createAccountScreen,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
