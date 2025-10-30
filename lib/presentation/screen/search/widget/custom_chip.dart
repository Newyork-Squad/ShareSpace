import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';

class CustomChip extends StatefulWidget {
  final String label;
  final String icon;
  bool isSelected;
  final VoidCallback? onSelect;

  CustomChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.icon = '',
    this.onSelect,
  });

  @override
  State<CustomChip> createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        widget.onSelect?.call();
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? const Color(0xFF0A84FF).withValues(alpha: 0.1)
              : const Color(0xFFF9FBFB),
          border: Border.all(
            color: widget.isSelected
                ? const Color(0x3D84E2FE).withValues(alpha: 0.24)
                : const Color(0x141F1F1F),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon.isNotEmpty) ...[
              SvgPicture.asset(
                widget.icon,
                colorFilter: widget.isSelected
                    ? ColorFilter.mode(Colors.blueAccent, BlendMode.srcIn)
                    : null,
                width: 16,
                height: 16,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              widget.label,
              style: TextStyle(
                color: widget.isSelected ? Colors.blue : Colors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
