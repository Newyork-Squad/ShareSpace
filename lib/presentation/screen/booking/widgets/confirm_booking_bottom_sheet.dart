import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';

class ConfirmBookingBottomSheet extends StatelessWidget {
  final String roomName;
  final String price;
  final String date;
  final String time;

  const ConfirmBookingBottomSheet({
    super.key,
    required this.roomName,
    required this.price,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Confirm Booking',
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
          const SizedBox(height: 32),

          // Icon
        Container(
          width: 64,
          height: 64,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colors.blueVariant,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: theme.colors.stroke.withOpacity(0.08),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x8036CEFB),
                offset: Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          ),
          child: SvgPicture.asset(
            'assets/icons/confirmed.svg',
            color: theme.colors.primary,
            width: 30,
            height: 30,
          ),),

          const SizedBox(height: 12),

          // Room title
          Text(
            roomName,
            style: theme.typography.textTheme.labelLarge?.copyWith(
              color: theme.colors.title,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height:5),

          // Price, Date, Time Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/attach_money.svg',
                width: 20,
                height: 20,
                color: theme.colors.body,
              ),
              const SizedBox(width: 4),
              Text(
                price,
                style:
                  theme.typography.textTheme.labelSmall?.copyWith(
                  color: theme.colors.body,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 12),
              SvgPicture.asset(
                'assets/icons/calender.svg',
                width: 20,
                height: 20,
                color: theme.colors.body,

              ),
              const SizedBox(width: 4),
              Text(
                date,
                style:
                theme.typography.textTheme.labelSmall?.copyWith(
                  color: theme.colors.body,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 12),
              SvgPicture.asset(
                'assets/icons/clock.svg',
                width: 20,
                height: 20,
                color: theme.colors.body,
              ),
              const SizedBox(width: 4),
              Text(
                time,
                style:
                theme.typography.textTheme.labelSmall?.copyWith(
                  color: theme.colors.body,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Question Text
           Text(
            'Are you sure to continue with booking this room?',
            textAlign: TextAlign.center,
            maxLines: 2,
            style:theme.typography.textTheme.bodyMedium?.copyWith(
              color: theme.colors.body,
              fontWeight: FontWeight.w400,
          ),

           ),
          const SizedBox(height: 24),

          // Confirm Button
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
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            ),
            child: const Text(
              'Confirm',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      )       ],
      ),
    );
  }
}

