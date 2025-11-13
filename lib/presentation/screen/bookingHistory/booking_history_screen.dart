import 'package:flutter/material.dart';
import 'package:share_space/resources/app_strings.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text(AppStrings.bookingHistoryScreenTitle)),
    );
  }
}
