import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../di/injection.dart';
import '../../../domain/usecase/authentication/create_account_usecase.dart';
import '../../design_system/colors/app_color.dart';
import '../../design_system/typography/app_typography.dart';
import '../login/login_widget/phone_input_field.dart';
import 'create_account_widgets/app_text_field.dart';
import 'create_account_widgets/create_account_button.dart';
import 'create_account_widgets/gender_selector.dart';
import 'create_account_widgets/profile_image_picker.dart';
import 'cubit/create_account_cubit.dart';
import 'cubit/create_account_state.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateAccountCubit(getIt<CreateAccountUseCase>()),
      child: const CreateAccountView(),
    );
  }
}

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? selectedImageUrl;
  String? confirmPasswordError;
  bool isFormValid = false;
  bool hasPhoneError = false;

  @override
  void initState() {
    super.initState();
    nameController.addListener(_validateForm);
    phoneController.addListener(_validateForm);
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
    confirmPasswordController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      isFormValid = nameController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty &&
          context.read<CreateAccountCubit>().gender != null &&
          !hasPhoneError; // ✅ التأكد من أن رقم الهاتف صحيح
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    bioController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _onCreateAccount() {
    final cubit = context.read<CreateAccountCubit>();

    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        confirmPasswordError =
        "Confirm password does not match the password.";
      });
      return;
    } else {
      setState(() {
        confirmPasswordError = null;
      });
    }

    cubit.createAccount(imageUrl: selectedImageUrl);
  }

  void _onLoginTap() {
    Navigator.pop(context);
  }

  void showCustomTopSnackBar({
    required String title,
    required String message,
    bool isError = true,
  }) {
    showTopSnackBar(
      Overlay.of(context)!,
      SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                isError
                    ? 'assets/images/toast_massage_background_error.png'
                    : 'assets/images/toast_massage_background_success.png',
              ),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: isError
                    ? const Color(0x29AF3333)
                    : const Color(0x2933AF80),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => '',
                  child: SvgPicture.asset('assets/icons/close_icon.svg'),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SvgPicture.asset(
                      isError
                          ? 'assets/icons/error_icon.svg'
                          : 'assets/icons/success_icon.svg',
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTypography()
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                            color: AppColors.light.title,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          message,
                          style: AppTypography()
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                            color: AppColors.light.body,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      snackBarPosition: SnackBarPosition.top,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CreateAccountCubit, CreateAccountState>(
        listener: (context, state) {
          if (state is CreateAccountSuccess) {
            showCustomTopSnackBar(
              title: 'Success',
              message: 'Account created successfully!',
              isError: false,
            );
            Navigator.pop(context);
          } else if (state is CreateAccountError) {
            final errorMessage = state.message.trim().isEmpty
                ? 'Unexpected error occurred.'
                : state.message;
            showCustomTopSnackBar(
              title: 'Error',
              message: errorMessage,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<CreateAccountCubit>();
          final isLoading = state is CreateAccountLoading;

          return Stack(
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
                        style: AppTypography()
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                          color: AppColors.light.title,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Please enter your information to create account.',
                        textAlign: TextAlign.center,
                        style: AppTypography()
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                          color: AppColors.light.body,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ProfileImagePicker(
                        onImageSelected: (imageUrl) {
                          selectedImageUrl = imageUrl;
                        },
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        controller: nameController,
                        hintText: 'Full name',
                        icon: 'assets/icons/user_name_icon.svg',
                        onChanged: cubit.updateFullName,
                      ),
                      const SizedBox(height: 16),
                      PhoneInputField(
                        controller: phoneController,
                        onChanged: cubit.updatePhoneNumber,
                        onValidationChanged: (error) {
                          hasPhoneError = error;
                          _validateForm();
                        },
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        controller: emailController,
                        hintText: 'Email',
                        icon: 'assets/icons/mail_account_icon.svg',
                        onChanged: cubit.updateEmail,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        controller: bioController,
                        hintText: 'Bio',
                        icon: null,
                        maxLines: 5,
                        isBioField: true,
                        onChanged: cubit.updateBio,
                      ),
                      const SizedBox(height: 16),
                      GenderSelector(
                        selectedGender: cubit.gender,
                        onGenderSelected: (gender) {
                          cubit.updateGender(gender);
                          _validateForm();
                        },
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        icon: 'assets/icons/user_name_icon.svg',
                        isPassword: true,
                        onChanged: cubit.updatePassword,
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        controller: confirmPasswordController,
                        hintText: 'Confirm password',
                        icon: 'assets/icons/user_name_icon.svg',
                        isPassword: true,
                        onChanged: cubit.updateConfirmPassword,
                        errorText: confirmPasswordError,
                      ),
                      const SizedBox(height: 29),
                      CreateAccountButton(
                        text: isLoading ? 'Creating...' : 'Create account',
                        isEnabled: !isLoading && isFormValid,
                        onPressed:
                        (!isLoading && isFormValid) ? _onCreateAccount : null,
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: _onLoginTap,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have account? ',
                              style: AppTypography()
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                color: AppColors.light.body,
                              ),
                            ),
                            Text(
                              'Login',
                              style: AppTypography()
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
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
              if (isLoading)
                Container(
                  color: Colors.black26,
                  child:
                  const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }
}