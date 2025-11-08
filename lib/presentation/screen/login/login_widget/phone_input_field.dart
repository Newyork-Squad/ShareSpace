import 'package:flutter/material.dart';
import '../../../design_system/colors/app_color.dart';
import '../../../design_system/typography/app_typography.dart';

class PhoneInputField extends StatefulWidget {
  final TextEditingController controller;
  final String? errorText;
  final Function(String)? onChanged;

  const PhoneInputField({
    super.key,
    required this.controller,
    this.errorText,
    this.onChanged,
  });

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  String selectedCountryCode = '+964';
  final List<String> countryCodes = ['+964', '+20', '+966', '+971', '+1', '+44'];

  void _notifyPhoneChange() {
    final phoneNumber = widget.controller.text.trim();
    if (phoneNumber.isNotEmpty) {
      final fullPhoneNumber = '$selectedCountryCode$phoneNumber';
      widget.onChanged?.call(fullPhoneNumber);
    } else {
      widget.onChanged?.call('');
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;
    final borderColor = hasError ? AppColors.light.red : AppColors.light.stroke;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.light.surfaceLow,
                  border: Border.all(color: borderColor, width: 0.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/arrow_down_icon.png',
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 4),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedCountryCode,
                        items: countryCodes
                            .map(
                              (code) => DropdownMenuItem(
                            value: code,
                            child: Text(
                              code,
                              style: AppTypography()
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: AppColors.light.body),
                            ),
                          ),
                        )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCountryCode = value!;
                          });
                          _notifyPhoneChange();
                        },
                        icon: const SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 2),
            Expanded(
              flex: 7,
              child: Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: borderColor,
                    width: 0.5,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset(
                        'assets/images/calling_icon.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: widget.controller,
                        keyboardType: TextInputType.phone,
                        style: AppTypography()
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.light.title),
                        decoration: InputDecoration(
                          hintText: 'Phone number',
                          hintStyle: AppTypography()
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: AppColors.light.body),
                          border: InputBorder.none,
                          isCollapsed: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: (_) {
                          _notifyPhoneChange();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Text(
              widget.errorText!,
              style: AppTypography().textTheme.labelSmall?.copyWith(
                color: AppColors.light.red,
              ),
            ),
          ),
      ],
    );
  }
}