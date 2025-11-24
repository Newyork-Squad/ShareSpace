import 'dart:async';
import 'package:flutter/material.dart';
import '../../../design_system/theme/app_theme.dart';

class OtpResendText extends StatefulWidget {
  final VoidCallback onResend;

  const OtpResendText({
    super.key,
    required this.onResend,
  });

  @override
  State<OtpResendText> createState() => _OtpResendTextState();
}

class _OtpResendTextState extends State<OtpResendText> {
  int _secondsRemaining = 44;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsRemaining = 44);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _handleResend() {
    widget.onResend();
    _startTimer();
  }

  String _formatTime() {
    final minutes = _secondsRemaining ~/ 60;
    final seconds = _secondsRemaining % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final canResend = _secondsRemaining == 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn't receive code? ",
          style: theme.typography.textTheme.bodySmall?.copyWith(
            color: theme.colors.body,
          ),
        ),
        GestureDetector(
          onTap: canResend ? _handleResend : null,
          child: Text(
            canResend ? 'Resend' : 'Resend in ${_formatTime()}',
            style: theme.typography.textTheme.bodySmall?.copyWith(
              color: canResend ? theme.colors.primary : theme.colors.hint,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

