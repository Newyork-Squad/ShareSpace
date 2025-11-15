import 'package:flutter/material.dart';
import 'package:share_space/presentation/design_system/colors/app_color.dart';
import 'package:share_space/presentation/screen/booking/widgets/calendar_widget.dart';
import 'package:share_space/presentation/screen/booking/widgets/confirm_button.dart';
import 'package:share_space/presentation/screen/booking/widgets/duration_widget.dart';
import 'package:share_space/presentation/screen/booking/widgets/payment_widget.dart';
import 'package:share_space/presentation/screen/booking/widgets/time_slot_widget.dart';

class BookRoomScreen extends StatelessWidget {
  const BookRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light.surfaceLow,
      appBar: AppBar(
        title: const Text('Book Room'),
        backgroundColor: AppColors.light.surfaceLow,
        elevation: 0,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CalendarWidget(),
            SizedBox(height: 16),
            TimeSlotWidget(),
            SizedBox(height: 16),
            DurationWidget(),
            SizedBox(height: 16),
            PaymentWidget(),
            SizedBox(height: 24),
            ConfirmButton(),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
