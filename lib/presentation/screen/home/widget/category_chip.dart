import 'package:flutter/material.dart';

import '../../../design_system/theme/app_theme.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return FilterChip(
      label: Text(
        label,
        style: theme.typography.textTheme.labelSmall?.copyWith(
          color: isSelected ? theme.colors.onPrimary : theme.colors.body,
        ),
      ),
      selected: isSelected,
      onSelected: onTap != null ? (value) => onTap!() : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: theme.colors.surface,
      selectedColor: theme.colors.secondary,
      side: isSelected
          ? BorderSide.none
          : BorderSide(color: theme.colors.stroke, width: 0.5),
      showCheckmark: false,
    );
  }
}
