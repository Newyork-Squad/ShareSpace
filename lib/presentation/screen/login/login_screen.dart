import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/di/injection.dart';
import 'package:share_space/presentation/design_system/colors/app_color.dart';
import 'package:share_space/presentation/design_system/typography/app_typography.dart';
import 'package:share_space/presentation/routes/routes.dart';
import 'package:share_space/presentation/screen/login/state/login_cubit.dart';

import '../../design_system/theme/app_theme.dart';
import '../../design_system/widget/app_text_field.dart';
import 'package:share_space/resources/app_strings.dart';
import 'login_widget/app_logo.dart';
import 'login_widget/login_button.dart';
import '../../design_system/widget/phone_input_field.dart';
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
  String fullPhoneNumber = '';
  bool hasPhoneError = false;

  void _validateForm() {
    final valid =
        phoneController.text.trim().isNotEmpty &&
            passwordController.text.trim().isNotEmpty &&
            !hasPhoneError;
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
    final phoneNumber = fullPhoneNumber.trim();
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
            onTap: () => FocusScope.of(context).unfocus(),
            behavior: HitTestBehavior.translucent,
            child: BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.of(context).colors.primary,
                    ),
                  );
                }
                return Stack(
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
                                  left: 16, right: 16, top: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const AppLogo(),
                                  const SizedBox(height: 24),
                                  Text(
                                    AppStrings.loginWelcomeBack,
                                    style: AppTypography()
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                      color: AppColors.light.title,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    AppStrings.loginInstructions,
                                    textAlign: TextAlign.center,
                                    style: AppTypography()
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                      color: AppColors.light.body,
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  PhoneInputField(
                                    controller: phoneController,
                                    onChanged: (value) {
                                      fullPhoneNumber = value;
                                    },
                                    onValidationChanged: (error) {
                                      hasPhoneError = error;
                                      _validateForm();
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  AppTextField(
                                    controller: passwordController,
                                    hintText: 'Password',
                                    icon: 'assets/icons/user_name_icon.svg',
                                    isPassword: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ValueListenableBuilder<bool>(
                            valueListenable: isFormValid,
                            builder: (context, valid, _) {
                              return Container(
                                color: AppColors.light.surfaceLow.withValues(
                                  alpha: 0.9,
                                ),
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 12),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    LoginButton(
                                      isEnabled: valid,
                                      onPressed: () => _handleLogin(context),
                                    ),
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
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
