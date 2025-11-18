import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../design_system/theme/app_theme.dart';

class OtpInputFields extends StatefulWidget {
  final ValueChanged<String> onCompleted;
  final ValueChanged<String> onChanged;

  const OtpInputFields({
    super.key,
    required this.onCompleted,
    required this.onChanged,
  });

  @override
  OtpInputFieldsState createState() => OtpInputFieldsState();
}

class OtpInputFieldsState extends State<OtpInputFields> {
  static const _otpLength = 6;

  final List<TextEditingController> _controllers =
      List.generate(_otpLength, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(_otpLength, (_) => FocusNode());

  OtpInputFieldsState() {
    for (var i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].onKeyEvent = (node, event) => _handleKeyEvent(i, event);
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  KeyEventResult _handleKeyEvent(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        index > 0 &&
        _controllers[index].text.isEmpty) {
      final previousIndex = index - 1;
      FocusScope.of(context).requestFocus(_focusNodes[previousIndex]);
      final previousController = _controllers[previousIndex];
      if (previousController.text.isNotEmpty) {
        previousController.clear();
        _notifyCodeChanged();
      }
      setState(() {});
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  void _handleChange(int index, String value) {
    var nextValue = value;
    if (nextValue.length > 1) {
      nextValue = nextValue.substring(nextValue.length - 1);
      _controllers[index].text = nextValue;
      _controllers[index].selection =
          TextSelection.collapsed(offset: nextValue.length);
    }

    if (nextValue.isNotEmpty) {
      if (index < _otpLength - 1) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        FocusScope.of(context).unfocus();
      }
    }

    setState(() {});

    _notifyCodeChanged();
  }

  void clear() {
    if (!mounted) return;
    for (final controller in _controllers) {
      controller.clear();
    }
    setState(() {});
    _notifyCodeChanged();
    if (_focusNodes.isNotEmpty) {
      FocusScope.of(context).requestFocus(_focusNodes.first);
    }
  }

  void _notifyCodeChanged() {
    final code = _controllers.map((controller) => controller.text).join();
    widget.onChanged(code);

    final isComplete =
        code.length == _otpLength && !_controllers.any((c) => c.text.isEmpty);
    if (isComplete) {
      widget.onCompleted(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_otpLength, (index) {
        final isFilled = _controllers[index].text.isNotEmpty;
        final allFilled = _controllers.every((c) => c.text.isNotEmpty);

        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              cursorColor: theme.colors.primary,
              style: theme.typography.textTheme.headlineSmall?.copyWith(
                color: theme.colors.primary,
                fontWeight: FontWeight.w600,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                counterText: '',
                filled: true,
                fillColor: isFilled || allFilled
                    ? theme.colors.blueVariant
                    : theme.colors.surfaceLow,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.colors.stroke,
                    width: 0.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.colors.stroke,
                    width: 0.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.colors.primary,
                    width: 1.5,
                  ),
                ),
              ),
              onChanged: (value) => _handleChange(index, value),
            ),
          ),
        );
      }),
    );
  }
}
