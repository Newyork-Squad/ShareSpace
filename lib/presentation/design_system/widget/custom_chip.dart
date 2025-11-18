import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';
import '../typography/app_typography.dart';

class CustomChip extends StatefulWidget {
  final String label;
  Color labelColor;
  final String icon;
  bool isSelected;
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

    return GestureDetector(
      onTap: () => setState(() {
        widget.onSelect?.call();
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? theme.colors.blueVariant
              : theme.colors.surface,
          border: Border.all(
            color: widget.isSelected
                ? theme.colors.primary
                : theme.colors.stroke,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon.isNotEmpty) ...[
              SvgPicture.asset(
                widget.icon,
                colorFilter: widget.isSelected
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
                color: widget.isSelected
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
