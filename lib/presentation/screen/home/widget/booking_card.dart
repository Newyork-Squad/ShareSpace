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
    return Card(
      color: theme.colors.surfaceLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      elevation: 6,
      child: InkWell(
        onTap: onClick,
        child: SizedBox(
          height: 172,
          child: Stack(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
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
                bottom: 0,
                child: ElevatedButton(
                  onPressed: onClick,
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(120, 60),
                    backgroundBuilder: (context, _, __) => Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 12,
                          strokeAlign: BorderSide.strokeAlignCenter,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        color: theme.colors.primary,
                      ),
                    ),
                  ),
                  child: Text(
                    'Book',
                    style: theme.typography.textTheme.labelSmall?.copyWith(
                      color: Colors.white, //theme.colors.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
