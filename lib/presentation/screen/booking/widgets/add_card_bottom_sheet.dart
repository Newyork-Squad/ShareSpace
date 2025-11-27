import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';

import '../../../design_system/colors/app_color.dart';
import '../../../design_system/typography/app_typography.dart';
class AddCardBottomSheet extends StatefulWidget {
  const AddCardBottomSheet({super.key});

  @override
  State<AddCardBottomSheet> createState() => _AddCardBottomSheetState();
}

class _AddCardBottomSheetState extends State<AddCardBottomSheet> {
  final TextEditingController cardController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  bool isEnabled = false;

  @override
  void initState() {
    super.initState();
    cardController.addListener(_updateState);
    expiryController.addListener(_updateState);
    cvvController.addListener(_updateState);
  }

  void _updateState() {
    setState(() {
      isEnabled = cardController.text.trim().isNotEmpty &&
          expiryController.text.trim().isNotEmpty &&
          cvvController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    cardController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  void _onAddCardPressed() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add payment card',
                  style: theme.typography.textTheme.titleSmall?.copyWith(
                    color: theme.colors.title,
                    fontWeight: FontWeight.w500,
                  ),
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

            // Card number field
            TextField(
              controller: cardController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Image.asset(
                  'assets/images/card.png',
                  width: 24,
                  height: 24,
                ),
                hintText: 'Card number',
                hintStyle: theme.typography.textTheme.labelMedium?.copyWith(
                  color: theme.colors.body,
                  fontWeight: FontWeight.w500,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(color: theme.colors.stroke, width: 0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(color: theme.colors.stroke, width: 0.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: theme.colors.stroke, width: 0.5),
                ),
                filled: true,
                fillColor: theme.colors.surfaceLow,
              ),
            ),
            const SizedBox(height: 12),

            // Row with expiry and CVV
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: expiryController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      prefixIcon: Image.asset(
                        'assets/images/calender.png',
                        width: 24,
                        height: 24,
                      ),
                      hintText: 'MM/YY',
                      hintStyle:
                      theme.typography.textTheme.labelMedium?.copyWith(
                        color: theme.colors.body,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide:
                        BorderSide(color: theme.colors.stroke, width: 0.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide:
                        BorderSide(color: theme.colors.stroke, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                        BorderSide(color: theme.colors.stroke, width: 0.5),
                      ),
                      filled: true,
                      fillColor: theme.colors.surfaceLow,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: cvvController,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'CVV',
                      hintStyle:
                      theme.typography.textTheme.labelMedium?.copyWith(
                        color: theme.colors.body,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide:
                        BorderSide(color: theme.colors.stroke, width: 0.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide:
                        BorderSide(color: theme.colors.stroke, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                        BorderSide(color: theme.colors.stroke, width: 0.5),
                      ),
                      filled: true,
                      fillColor: theme.colors.surfaceLow,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Add Card button
            SizedBox(
              width: 328,
              height: 52,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF50B5E7), // #50B5E7 0%
                      Color(0xFF19C6F9), // #19C6F9 100%
                    ],
                  ),
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: const [

                    BoxShadow(
                      color: Color(0x8036CEFB),
                      offset: Offset(0, 4),
                      blurRadius: 8,
                    ),
                    BoxShadow(
                      color: Color(0x3D84E2FE),
                      offset: Offset(0, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () =>_onAddCardPressed(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  ),
                  child: const Text(
                    'Add card ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}