import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';
import '../typography/app_typography.dart';

class CustomChip extends StatefulWidget {
  final String label;
  final Color labelColor;
  final String icon;
  bool isSelected;
  final bool isDefaultSelected;
  final VoidCallback? onSelect;
  final int width;
  final int height;
  final TextStyle? labelStyle;
  final Color? fontColor;

  CustomChip({
    super.key,
    required this.label,
    this.labelColor = const Color(0x991F1F1F),
    this.icon = '',
    this.isSelected = false,
    this.isDefaultSelected = true,
    this.onSelect,
    this.width = 37,
    this.height = 22,
    this.labelStyle,
    this.fontColor,
  });

  @override
  State<CustomChip> createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    final bool isSelected = widget.isSelected;
    final bool isDefault = widget.isDefaultSelected;

    final double borderWidth = (isSelected && !isDefault) ? 1 : 0.5;

    final List<BoxShadow>? shadow = (isSelected && !isDefault)
        ? [
            BoxShadow(
              color: const Color(0x3D84E2FE),
              offset: const Offset(0, 4),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ]
        : null;

    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onSelect?.call();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? theme.colors.blueVariant : theme.colors.surface,
          border: Border.all(
            color: isSelected ? theme.colors.primary : theme.colors.stroke,
            width: borderWidth,
          ),
          borderRadius: BorderRadius.circular(100),
          boxShadow: shadow,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon.isNotEmpty) ...[
              SvgPicture.asset(
                widget.icon,
                colorFilter: isSelected
                    ? ColorFilter.mode(theme.colors.primary, BlendMode.srcIn)
                    : null,
                width: 12,
                height: 12,
              ),
              const SizedBox(width: 2),
            ],
            Text(
              widget.label,
              style: (widget.labelStyle ?? AppTypography.labelXSmall).copyWith(
                color: isSelected
                    ? theme.colors.primary
                    : (widget.fontColor ?? widget.labelColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
