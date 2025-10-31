import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SecondaryButton extends StatefulWidget {
  final Function() onPressed;
  final String label;
  final bool isBig;
  bool isDisabled;

  SecondaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isBig = true,
    this.isDisabled = false,
  });

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return ElevatedButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
      ),
      onPressed: widget.isDisabled ? null : widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: widget.isBig ? 52 : 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.isDisabled
              ? theme.colors.blueVariant
              : theme.colors.disable,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 0.5, color: theme.colors.stroke),
        ),
        child: Text(
          widget.label,
          style: theme.typography.textTheme.labelMedium?.copyWith(
            color: widget.isDisabled
                ? theme.colors.primary
                : theme.colors.onPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
    ;
  }
}
