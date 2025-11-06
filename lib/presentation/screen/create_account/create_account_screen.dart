import 'package:flutter/material.dart';
import '../../design_system/colors/app_color.dart';
import '../../design_system/typography/app_typography.dart';
import '../login/login_widget/phone_input_field.dart';
import 'create_account_widgets/app_text_field.dart';
import 'create_account_widgets/create_account_button.dart';
import 'create_account_widgets/gender_selector.dart';
import 'create_account_widgets/profile_image_picker.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String selectedGender = '';
  bool isFormValid = false;

  @override
  void initState() {
    super.initState();
    nameController.addListener(_validateForm);
    phoneController.addListener(_validateForm);
    emailController.addListener(_validateForm);
    bioController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
    confirmPasswordController.addListener(_validateForm);
  }

  void _validateForm() {
    final allFieldsFilled =
        nameController.text.trim().isNotEmpty &&
            phoneController.text.trim().isNotEmpty &&
            emailController.text.trim().isNotEmpty &&
            passwordController.text.trim().isNotEmpty &&
            confirmPasswordController.text.trim().isNotEmpty &&
            selectedGender.isNotEmpty;

    final passwordsMatch =
        passwordController.text.trim() == confirmPasswordController.text.trim();

    final valid = allFieldsFilled && passwordsMatch;

    if (isFormValid != valid) {
      setState(() {
        isFormValid = valid;
      });
    }
  }

  void _onCreateAccount() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account Created Successfully!')),
    );
  }

  void _onLoginTap() {
    print('Navigate to Login Screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/create_account_background.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 9),
                  Text(
                    'Create account',
                    style: AppTypography().textTheme.titleMedium?.copyWith(
                      color: AppColors.light.title,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Please enter your information to create account.',
                    textAlign: TextAlign.center, // 🟢 هنا عشان يكون النص في الوسط
                    style: AppTypography().textTheme.bodyMedium?.copyWith(
                      color: AppColors.light.body,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const ProfileImagePicker(),
                  const SizedBox(height: 16),

                  AppTextField(
                    controller: nameController,
                    hintText: 'Full name',
                    icon: 'assets/icons/user_name_icon.svg',
                  ),
                  const SizedBox(height: 16),
                  PhoneInputField(controller: phoneController),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: emailController,
                    hintText: 'Email',
                    icon: 'assets/icons/mail_account_icon.svg',
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: bioController,
                    hintText: 'Bio',
                    icon: null,
                    maxLines: 5,
                    isBioField: true,
                  ),
                  const SizedBox(height: 16),
                  GenderSelector(
                    selectedGender: selectedGender,
                    onGenderSelected: (gender) {
                      setState(() {
                        selectedGender = gender;
                      });
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
                  const SizedBox(height: 12),
                  AppTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm password',
                    icon: 'assets/icons/user_name_icon.svg',
                    isPassword: true,
                  ),
                  const SizedBox(height: 29),

                  CreateAccountButton(
                    text: 'Create account',
                    isEnabled: isFormValid,
                    onPressed: _onCreateAccount,
                  ),

                  const SizedBox(height: 12),

                  GestureDetector(
                    onTap: _onLoginTap,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have account? ',
                          style: AppTypography().textTheme.labelMedium?.copyWith(
                            color: AppColors.light.body,
                          ),
                        ),
                        Text(
                          'Login',
                          style: AppTypography().textTheme.labelMedium?.copyWith(
                            color: AppColors.light.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
