import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_theme.dart';

class ErrorScreen extends StatelessWidget {
  final String title;
  final String description;
  final bool hasAppBar;

  const ErrorScreen({
    super.key,
    this.title = "Something wrong happen!",
    this.description = "Please check your internet connection and try again.",
    this.hasAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hasAppBar
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back,
                    color: AppTheme.of(context).colors.title),
                onPressed: () => Navigator.maybePop(context),
                tooltip: 'Back',
              ),
            )
          : null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.of(context).colors.errorVariant,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/alert.svg',
                  width: 40,
                  height: 40,
                  color: AppTheme.of(context).colors.red,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: AppTheme.of(context)
                  .typography
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppTheme.of(context).colors.title),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Text(
                description,
                style: AppTheme.of(context)
                    .typography
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppTheme.of(context).colors.body),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
