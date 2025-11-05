import 'package:flutter/material.dart';

import '../../../design_system/theme/app_theme.dart';

class BookingCard extends StatelessWidget {
  final String label;
  final String description;
  final String imageUrl;
  final VoidCallback? onClick;

  const BookingCard({
    super.key,
    required this.label,
    required this.description,
    required this.imageUrl,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return SizedBox(
      height: 180,
      width: 320,
      child: Stack(
        children: [
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    label,
                    style: theme.typography.textTheme.titleMedium?.copyWith(
                      color: theme.colors.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 0),
                  Text(
                    "$description\n",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.typography.textTheme.bodySmall?.copyWith(
                      color: theme.colors.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: -8,
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: WidgetStateProperty.all(0),
                backgroundColor: WidgetStateProperty.all(Colors.transparent),
              ),
              onPressed: onClick,
              child: Ink(
                width: 90,
                height: 40,
                decoration: BoxDecoration(
                  color: theme.colors.primary,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white, width: 4),
                ),
                child: Center(
                  child: Text(
                    'Book Now',
                    style: theme.typography.textTheme.labelSmall?.copyWith(
                      color: theme.colors.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
