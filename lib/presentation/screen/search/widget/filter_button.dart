import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        padding: const EdgeInsets.all(0),
        minimumSize: const Size(48, 48),
        elevation: 0,
      ),
      onPressed: () {
        // TODO: Implement filter action
      },
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF50B5E7), Color(0xFF19C6F9)],
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Container(
          padding: const EdgeInsets.all(14),
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/icons/filter.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              Colors.white, // TODO: use theme colors
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
