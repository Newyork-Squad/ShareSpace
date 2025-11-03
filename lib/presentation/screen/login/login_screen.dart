import 'package:flutter/material.dart';
import 'package:share_space/presentation/design_system/colors/app_color.dart';
import 'package:share_space/presentation/design_system/typography/app_typography.dart';
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

  bool get _isFormValid =>
      phoneController.text.isNotEmpty && passwordController.text.isNotEmpty;

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light.surfaceLow,
      body: Stack(
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
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const AppLogo(),
                        const SizedBox(height: 24),
                        Text(
                          "Welcome Back",
                          style: AppTypography().textTheme.titleMedium?.copyWith(
                            color: AppColors.light.title,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Please enter your phone number and password to access your booking",
                          textAlign: TextAlign.center,
                          style: AppTypography().textTheme.bodyMedium?.copyWith(
                            color: AppColors.light.body,
                          ),
                        ),
                        const SizedBox(height: 32),
                        PhoneInputField(
                          controller: phoneController,
                          onChanged: () => setState(() {}),
                        ),
                        const SizedBox(height: 16),
                        PasswordInputField(
                          controller: passwordController,
                          onChanged: () => setState(() {}),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  color: AppColors.light.surfaceLow.withOpacity(0.9),
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LoginButton(
                        isEnabled: _isFormValid,
                        onPressed: _isFormValid
                            ? () {
                        }
                            : null,
                      ),
                      const SizedBox(height: 12),
                      RegisterText(
                        onTap: () {
                        },
                      ),
                      const SizedBox(height: 16)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
