import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PrimaryButton extends StatefulWidget {
  final Function() onPressed;
  final String label;
  final bool isBig;
  bool isDisabled;

  PrimaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isBig = true,
    this.isDisabled = false,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
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
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: widget.isDisabled
                ? [theme.colors.disable, theme.colors.disable]
                : [Color(0xFF50B5E7), Color(0xFF19C6F9)],
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          widget.label,
          style: theme.typography.textTheme.labelMedium?.copyWith(
            color: theme.colors.onPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
    ;
  }
}
