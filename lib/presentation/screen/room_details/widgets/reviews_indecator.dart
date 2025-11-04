import 'package:flutter/material.dart';

import '../../../design_system/theme/app_theme.dart';

class ReviewsIndicator extends StatelessWidget {
  final String rateNumber;
  final double rateValue;

  const ReviewsIndicator({
    super.key,
    required this.rateNumber,
    required this.rateValue,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            rateNumber,
            style: theme.typography.textTheme.labelSmall?.copyWith(
              color: theme.colors.body,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          flex: 14,
          child: SizedBox(
            width: 180,
            height: 4,
            child: LinearProgressIndicator(
              value: rateValue,
              minHeight: 11,
              backgroundColor: theme.colors.stroke,
              borderRadius: BorderRadius.circular(100),
              valueColor: AlwaysStoppedAnimation(theme.colors.yellow),
            ),
          ),
        ),
      ],
    );
  }
}
