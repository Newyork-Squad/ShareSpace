import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_space/presentation/design_system/colors/app_color.dart';
import '../../../design_system/typography/app_typography.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final dynamic icon;
  final bool isPassword;
  final int maxLines;
  final bool isBioField;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.maxLines = 1,
    this.isBioField = false,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscure = true;

  Widget? _buildPrefixIcon() {
    if (widget.isPassword) {
      return Padding(
        padding: const EdgeInsets.only(left: 16, right: 12),
        child: SvgPicture.asset(
          'assets/icons/security_lock_icon.svg', // هنا استخدمنا svg
          width: 24,
          height: 24,
        ),
      );
    } else if (widget.icon == null || widget.isBioField) {
      return null;
    } else if (widget.icon is IconData) {
      return Icon(widget.icon as IconData);
    } else if (widget.icon is String) {
      return Padding(
        padding: const EdgeInsets.only(left: 4, top: 14, bottom: 14),
        child: SvgPicture.asset(widget.icon as String, width: 24, height: 24),
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.isBioField ? 16 : 30),
      borderSide: BorderSide(
        color: AppColors.light.stroke,
        width: 0.5,
      ),
    );

    return SizedBox(
      height: widget.isBioField ? 150 : null,
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword && _obscure,
        obscuringCharacter: '*',
        maxLines: widget.isBioField ? null : widget.maxLines,
        expands: widget.isBioField,
        textAlignVertical: widget.isBioField
            ? TextAlignVertical.top
            : TextAlignVertical.center,
        style: AppTypography().textTheme.bodyMedium?.copyWith(
          color: AppColors.light.title,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppTypography().textTheme.labelMedium?.copyWith(
            color: AppColors.light.body,
          ),
          prefixIcon: _buildPrefixIcon(),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
          suffixIcon: widget.isPassword
              ? Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () => setState(() => _obscure = !_obscure),
              child: SvgPicture.asset(
                _obscure
                    ? 'assets/icons/hide_password_icon.svg'
                    : 'assets/icons/show_password_icon.svg',
                width: 20,
                height: 20,
                color: AppColors.light.body,
              ),
            ),
          )
              : null,
          suffixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
          filled: widget.isBioField || widget.isPassword,
          fillColor:
          widget.isPassword ? Colors.white : AppColors.light.surfaceLow,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          border: border,
          enabledBorder: border,
          focusedBorder: border,
        ),
      ),
    );
  }
}
