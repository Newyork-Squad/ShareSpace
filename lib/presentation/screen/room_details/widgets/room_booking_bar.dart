import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../design_system/theme/app_theme.dart';


class RoomBookingBar extends StatelessWidget {
  final String price;
  const RoomBookingBar({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Container(
      width: 360,
      height: 76,
      decoration: BoxDecoration(
        color: theme.colors.surfaceLow,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),

      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/attach_money.svg',
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 8),
              Text(
                price,
                style: theme.typography.textTheme.labelMedium?.copyWith(
                  color: theme.colors.title,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          GestureDetector(
            onTap: (){},
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 160,
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF50B5E7),
                    Color(0xFF19C6F9),
                  ],
                ),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  const BoxShadow(
                    color: Color(0x8036CEFB),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                    spreadRadius: -4,
                  ),
                ],
              ),
              child: Text(
                'Book now',
                style: theme.typography.textTheme.labelMedium?.copyWith(
                  color: theme.colors.onPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
