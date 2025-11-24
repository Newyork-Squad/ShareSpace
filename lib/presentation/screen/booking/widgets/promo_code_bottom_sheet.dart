import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';

import '../../../design_system/colors/app_color.dart';
import '../../../design_system/typography/app_typography.dart';

class PromoCodeBottomSheet extends StatefulWidget {
  const PromoCodeBottomSheet({super.key});

  @override
  State<PromoCodeBottomSheet> createState() => _PromoCodeBottomSheetState();
}

class _PromoCodeBottomSheetState extends State<PromoCodeBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  bool isEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() => isEnabled = _controller.text.trim().isNotEmpty);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onApplyPressed() {
    // Handle your promo code logic here
    // which is if pormocode correct
    // or not and show the custom toast message.
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add promo code',
                style: theme.typography.textTheme.titleSmall?.copyWith(
                  color: theme.colors.title,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.start,
              ),
              IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/close.svg',
                  color: theme.colors.body,
                  width: 20,
                  height: 20,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          Divider(color: theme.colors.stroke, height: 1),
          const SizedBox(height: 21),

          TextField(
            controller: _controller,
            decoration: InputDecoration(
              prefixIcon: Image.asset(
                'assets/images/pormocode.png',
                width: 24,
                height: 24,
              ),
              hintText: 'Promo code',
              hintStyle: theme.typography.textTheme.labelMedium?.copyWith(
                color: theme.colors.body,
                fontWeight: FontWeight.w500,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(color: theme.colors.stroke, width: 0.5,),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide:  BorderSide(color: theme.colors.stroke, width: 0.5,),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: theme.colors.stroke, width: 0.5,),
              ),
              filled: true,
              fillColor: theme.colors.surfaceLow,
            ),
          ),

          const SizedBox(height: 24),

          // Apply button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: isEnabled ? _onApplyPressed : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isEnabled
                    ? AppColors.light.primary
                    : AppColors.light.stroke,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: Text(
                'Apply',
                style: AppTypography().textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}