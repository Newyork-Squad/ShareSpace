import 'package:flutter/material.dart';

import 'custom_loading_indicator.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CustomLoadingIndicator(),
      ),
    );
  }
}
