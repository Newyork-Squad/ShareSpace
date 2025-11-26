import 'package:flutter/material.dart';
import 'package:share_space/presentation/design_system/colors/app_color.dart';
import 'package:share_space/presentation/screen/booking/widgets/calendar_widget.dart';
import 'package:share_space/presentation/screen/booking/widgets/duration_widget.dart';
import 'package:share_space/presentation/screen/booking/widgets/payment_widget.dart';
import 'package:share_space/presentation/screen/booking/widgets/time_slot_widget.dart';
import 'package:share_space/resources/app_strings.dart';
import '../../design_system/widget/share_space_app_button.dart';

class BookRoomScreen extends StatelessWidget {
  const BookRoomScreen({super.key, this.roomId});


  final String? roomId;

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled = true;

    final resolvedRoomId = roomId ??
        (ModalRoute.of(context)?.settings.arguments as String?) ??
        '';

    return Scaffold(
      backgroundColor: AppColors.light.surfaceLow,
      appBar: AppBar(
        title: const Text('Book Room'),
        backgroundColor: AppColors.light.surfaceLow,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CalendarWidget(),
            const SizedBox(height: 16),
            const TimeSlotWidget(),
            const SizedBox(height: 16),
            const DurationWidget(),
            const SizedBox(height: 16),
            const PaymentWidget(),
            const SizedBox(height: 24),
            ShareSpaceAppButton(
              isEnabled: isButtonEnabled,
              text: AppStrings.bookingConfirmBookingButton,
              onPressed: () {

              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
