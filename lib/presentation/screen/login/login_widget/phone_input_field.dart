import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../design_system/colors/app_color.dart';
import '../../../design_system/typography/app_typography.dart';

class PhoneInputField extends StatefulWidget {
  final TextEditingController controller;
  final String? errorText;
  final Function(String)? onChanged;
  final Function(bool)? onValidationChanged;

  const PhoneInputField({
    super.key,
    required this.controller,
    this.errorText,
    this.onChanged,
    this.onValidationChanged, // ✅ لازم يتضاف هنا
  });

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  String selectedCountryCode = '+964';
  String? localError;

  final List<String> countryCodes = [
    '+964',
    '+20',
    '+966',
    '+971',
    '+1',
    '+44',
  ];

  // ✅ عدد الأرقام المطلوب لكل دولة
  final Map<String, int> requiredLengths = {
    '+964': 10, // العراق
    '+20': 10,  // مصر
    '+966': 9,  // السعودية
    '+971': 9,  // الإمارات
    '+1': 10,   // أمريكا
    '+44': 10,  // بريطانيا
  };

  void _notifyPhoneChange() {
    final phoneNumber = widget.controller.text.trim();

    if (phoneNumber.isEmpty) {
      setState(() => localError = null);
      widget.onValidationChanged?.call(false);
      widget.onChanged?.call('');
      return;
    }

    final validationMessage =
    validatePhoneNumber(selectedCountryCode, phoneNumber);

    if (validationMessage == null) {
      setState(() => localError = null);
      widget.onValidationChanged?.call(false); // ✅ مفيش error
      final fullPhoneNumber = '$selectedCountryCode$phoneNumber';
      widget.onChanged?.call(fullPhoneNumber);
    } else {
      setState(() => localError = validationMessage);
      widget.onValidationChanged?.call(true); // ❌ فيه error
      widget.onChanged?.call('');
    }
  }

  String? validatePhoneNumber(String countryCode, String phoneNumber) {
    final requiredLength = requiredLengths[countryCode];
    if (requiredLength == null) return 'Invalid country code';

    if (phoneNumber.length < requiredLength) {
      return 'Phone number must be $requiredLength digits';
    } else if (phoneNumber.length > requiredLength) {
      return 'Phone number must be $requiredLength digits only';
    }

    // ✅ التحقق من رقم الدولة
    switch (countryCode) {
      case '+20':
        if (!RegExp(r'^(1[0-5])').hasMatch(phoneNumber)) {
          return 'Egyptian numbers start with 10, 11, 12, or 15';
        }
        break;
      case '+966':
        if (!phoneNumber.startsWith('5')) {
          return 'Saudi numbers start with 5';
        }
        break;
      default:
        break;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null || localError != null;
    final borderColor =
    hasError ? AppColors.light.red : AppColors.light.stroke;

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
                        dropdownColor: AppColors.light.surface,
                        items: countryCodes
                            .map(
                              (code) => DropdownMenuItem(
                            value: code,
                            child: Text(
                              code,
                              style: AppTypography()
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                  color: AppColors.light.body),
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
                  border: Border.all(color: borderColor, width: 0.5),
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
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
                        onChanged: (_) => _notifyPhoneChange(),
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
              widget.errorText ?? localError!,
              style: AppTypography()
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: AppColors.light.red),
            ),
          ),
      ],
    );
  }
}
