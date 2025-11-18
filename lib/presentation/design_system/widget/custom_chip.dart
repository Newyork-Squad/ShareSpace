import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';
import '../colors/app_color.dart';
import '../typography/app_typography.dart';

enum ChipSize {
  body,
  title,
}

class CustomChip extends StatefulWidget {
  final String label;
  Color labelColor;
  final String icon;
  bool isSelected;
  final VoidCallback? onSelect;
  final ChipSize size;
  final TextStyle? labelStyle;

  CustomChip({
    super.key,
    required this.label,
    Color? labelColor,
    this.icon = '',
    this.isSelected = false,
    this.onSelect,
    this.size = ChipSize.body,
    this.labelStyle,
  }) : labelColor = labelColor ?? AppColors.light.title;

  @override
  State<CustomChip> createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  TextStyle _resolveTextStyle() {
    if (widget.labelStyle != null) return widget.labelStyle!;

    switch (widget.size) {
      case ChipSize.title:
        return AppTypography.labelXSmall.copyWith(fontWeight: FontWeight.w600);
      case ChipSize.body:
      default:
        return AppTypography.labelXSmall;
    }
  }

  EdgeInsets _resolvePadding() {
    switch (widget.size) {
      case ChipSize.title:
        return const EdgeInsets.symmetric(horizontal: 10, vertical: 6);
      case ChipSize.body:
      default:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 5);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return GestureDetector(
      onTap: () => setState(() {
        widget.onSelect?.call();
      }),
      child: Container(
        padding: _resolvePadding(),
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
              style: _resolveTextStyle().copyWith(
                color: widget.isSelected
                    ? theme.colors.primary
                    : widget.labelColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
