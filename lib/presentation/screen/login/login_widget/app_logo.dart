import 'package:flutter/material.dart';
import 'package:share_space/presentation/design_system/colors/app_color.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/share_space_logo.png'),
        Text(
          'ShareSpace',
          style: TextStyle(
            color: AppColors.light.primary,
            fontSize: 16,
            fontFamily: 'RocknRollOne',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}