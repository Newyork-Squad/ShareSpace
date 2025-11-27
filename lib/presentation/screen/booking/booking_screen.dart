import 'package:flutter/material.dart';
import 'package:share_space/resources/app_strings.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text(AppStrings.bookingScreenTitle)),
    );
  }
}
