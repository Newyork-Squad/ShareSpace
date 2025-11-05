import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../design_system/theme/app_theme.dart';
import '../../../widgets/app_primary_button.dart';

typedef SelectionSheetWidgetBuilder =
    Widget Function(BuildContext context, bool isSelected);

class SelectionSheetOption<T> {
  const SelectionSheetOption({
    required this.value,
    required this.label,
    this.subtitle,
    this.leadingBuilder,
    this.trailingBuilder,
  });

  final T value;
  final String label;
  final String? subtitle;
  final SelectionSheetWidgetBuilder? leadingBuilder;
  final SelectionSheetWidgetBuilder? trailingBuilder;
}

class SelectionSheet<T> extends StatefulWidget {
  const SelectionSheet({
    super.key,
    required this.title,
    required this.options,
    required this.initialValue,
    this.confirmLabel = 'Save',
    this.description,
    this.enableBackgroundDismiss = true,
    this.horizontalMargin = 0,
  }) : assert(options.length > 1, 'Provide at least two options');

  final String title;
  final String? description;
  final List<SelectionSheetOption<T>> options;
  final T initialValue;
  final String confirmLabel;
  final bool enableBackgroundDismiss;
  final double horizontalMargin;

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required List<SelectionSheetOption<T>> options,
    required T initialValue,
    String confirmLabel = 'Save',
    String? description,
    bool enableBackgroundDismiss = true,
    double horizontalMargin = 0,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SelectionSheet<T>(
        title: title,
        options: options,
        initialValue: initialValue,
        confirmLabel: confirmLabel,
        description: description,
        enableBackgroundDismiss: enableBackgroundDismiss,
        horizontalMargin: horizontalMargin,
      ),
    );
  }

  @override
  State<SelectionSheet<T>> createState() => _SelectionSheetState<T>();
}

class _SelectionSheetState<T> extends State<SelectionSheet<T>> {
  late T _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return SafeArea(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.enableBackgroundDismiss
            ? () => Navigator.of(context).maybePop()
            : null,
        child: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: widget.horizontalMargin,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.colors.surfaceLow,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SheetHeader(title: widget.title),
                      if (widget.description != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          widget.description!,
                          style: theme.typography.textTheme.bodySmall?.copyWith(
                            color: theme.colors.body,
                            height: 1.4,
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),
                      _buildOptions(context),
                      const SizedBox(height: 16),
                      AppPrimaryButton(
                        label: widget.confirmLabel,
                        onPressed: () =>
                            Navigator.of(context).pop(_selectedValue),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptions(BuildContext context) {
    final options = <Widget>[];
    for (var i = 0; i < widget.options.length; i++) {
      final option = widget.options[i];
      options.add(
        _SelectionTile<T>(
          option: option,
          selected: option.value == _selectedValue,
          onTap: () => setState(() => _selectedValue = option.value),
        ),
      );
      if (i != widget.options.length - 1) {
        options.add(const SizedBox(height: 12));
      }
    }

    final shouldScroll = widget.options.length > 4;
    if (!shouldScroll) {
      return Column(children: options);
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 360),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: options),
      ),
    );
  }
}

class _SheetHeader extends StatelessWidget {
  const _SheetHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            title,
            style: theme.typography.textTheme.bodyMedium?.copyWith(
              color: theme.colors.title,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 24 / 18,
            ),
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => Navigator.of(context).maybePop(),
          child: Icon(Icons.close, color: theme.colors.hint, size: 20),
        ),
      ],
    );
  }
}

class _SelectionTile<T> extends StatelessWidget {
  const _SelectionTile({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final SelectionSheetOption<T> option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final colors = theme.colors;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: selected ? colors.blueVariant : colors.surface,
            border: Border.all(
              color: selected ? colors.primary : colors.stroke,
              width: 1.5,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (option.leadingBuilder != null) ...[
                option.leadingBuilder!(context, selected),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.label,
                      style: theme.typography.textTheme.bodyMedium?.copyWith(
                        color: colors.title,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 24 / 16,
                      ),
                    ),
                    if (option.subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        option.subtitle!,
                        style: theme.typography.textTheme.bodySmall?.copyWith(
                          color: colors.body,
                          fontSize: 12,
                          height: 18 / 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              option.trailingBuilder != null
                  ? option.trailingBuilder!(context, selected)
                  : AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: selected ? 1 : 0,
                      child: SvgPicture.asset(
                        'assets/images/tick-double-03.svg',
                        width: 22,
                        height: 22,
                        colorFilter: ColorFilter.mode(
                          colors.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectionSheetBadge extends StatelessWidget {
  const SelectionSheetBadge({
    super.key,
    required this.highlighted,
    required this.child,
    this.size = 40,
  });

  factory SelectionSheetBadge.text({
    required String text,
    required bool highlighted,
    double size = 40,
  }) {
    return SelectionSheetBadge(
      highlighted: highlighted,
      size: size,
      child: Text(text),
    );
  }

  final bool highlighted;
  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final colors = theme.colors;

    final Widget content;
    if (child is Text) {
      final textWidget = child as Text;
      content = Text(
        textWidget.data ?? '',
        style: theme.typography.textTheme.bodyMedium?.copyWith(
          color: highlighted ? colors.onPrimary : colors.title,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      );
    } else {
      content = child;
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: highlighted ? colors.primary : colors.surface,
        border: Border.all(
          color: highlighted ? colors.primaryVariant : colors.stroke,
          width: 1.2,
        ),
      ),
      alignment: Alignment.center,
      child: content,
    );
  }
}
