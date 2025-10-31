import 'package:flutter/material.dart';
import '../../../design_system/colors/app_color.dart';
import '../../../design_system/typography/app_typography.dart';

class PasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback? onChanged;
  const PasswordInputField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscure,
      obscuringCharacter: '*',
      style: AppTypography().textTheme.bodyMedium?.copyWith(
        color: AppColors.light.title,
      ),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, right: 12),
          child: Image.asset(
            'assets/images/security_lock_icon.png',
            width: 24,
            height: 24,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: GestureDetector(
            onTap: () => setState(() => _obscure = !_obscure),
            child: Image.asset(
              _obscure
                  ? 'assets/images/show_password_icon.png'
                  : 'assets/images/show_password_icon.png',
              width: 20,
              height: 20,
              color: AppColors.light.body,
            ),
          ),
        ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
        hintText: 'Password',
        hintStyle: AppTypography().textTheme.labelMedium?.copyWith(
          color: AppColors.light.body,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: AppColors.light.stroke,
            width: 0.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: AppColors.light.stroke,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: AppColors.light.stroke,
            width: 0.5,
          ),
        ),
      ),
      onChanged: (_) => widget.onChanged?.call(),
    );
  }
}
