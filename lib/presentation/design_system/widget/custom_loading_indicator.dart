import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomLoadingIndicator extends StatefulWidget {
  const CustomLoadingIndicator({super.key, this.size = 40.0});
  final double size;

  @override
  State<CustomLoadingIndicator> createState() => _CustomLoadingIndicatorState();
}

class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * pi,
            child: child,
          );
        },
        child: CustomPaint(
          painter: _LoadingPainter(
            color: AppTheme.of(context).colors.primary,
          ),
          size: Size.square(widget.size),
        ),
      ),
    );
  }
}

class _LoadingPainter extends CustomPainter {
  final Color color;
  _LoadingPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const int count = 12;
    final double radius = size.width / 2;
    final Offset center = Offset(radius, radius);
    final Paint paint = Paint()..strokeCap = StrokeCap.round;

    for (int i = 0; i < count; i++) {
      final double opacity = (i + 1) / count;
      paint.color = color.withOpacity(opacity);
      
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate((2 * pi * i) / count);
      canvas.drawLine(
        Offset(radius * 0.6, 0),
        Offset(radius, 0),
        paint..strokeWidth = size.width / 10,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_LoadingPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
