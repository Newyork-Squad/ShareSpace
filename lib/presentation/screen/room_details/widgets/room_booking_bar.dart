import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../design_system/theme/app_theme.dart';
import '../../../design_system/widget/share_space_app_button.dart';
import '../../../routes/routes.dart';

class RoomBookingBar extends StatelessWidget {
  final String price;
  final String? roomId;

  const RoomBookingBar({super.key, required this.price, required this.roomId});

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

          SizedBox(
            width: 160,
            child: ShareSpaceAppButton(
              isEnabled: true,
              text: 'Book now',
              onPressed: () {
                Navigator.pushNamed(context, Routes.bookRoomScreen, arguments: roomId);
              },
            ),
          ),
        ],
      ),
    );
  }
}
