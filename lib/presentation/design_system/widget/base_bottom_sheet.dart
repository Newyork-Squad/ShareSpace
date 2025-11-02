import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_space/presentation/design_system/theme/app_theme_provider.dart';

import '../theme/app_theme.dart';

class BaseBottomSheet extends StatefulWidget {
  final Widget child;
  final String label;
  final Function() onClose;

  const BaseBottomSheet({
    super.key,
    required this.child,
    required this.label,
    required this.onClose,
  });

  @override
  State<BaseBottomSheet> createState() => _BaseBottomSheetState();
}

class _BaseBottomSheetState extends State<BaseBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return AppThemeProvider(
      child: Container(
        color: AppTheme.of(context).colors.surface,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(left: 16, right: 16, top: 24),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        widget.label,
                        style: AppTheme.of(context)
                            .typography
                            .textTheme
                            .titleSmall
                            ?.copyWith(
                              color: AppTheme.of(context).colors.title,
                            ),
                      ),
                      Expanded(child: SizedBox()),
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                          icon: SvgPicture.asset(
                            'assets/icons/cancel_circle.svg',
                          ),
                          onPressed: () {
                            widget.onClose();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Divider(
                    color: AppTheme.of(context).colors.stroke,
                    thickness: 1,
                    height: 0,
                  ),
                ],
              ),
            ),
            widget.child,
          ],
        ),
      ),
    );
  }
}
