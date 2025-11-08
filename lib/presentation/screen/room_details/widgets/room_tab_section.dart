import 'package:flutter/material.dart';
import '../../../design_system/theme/app_theme.dart';

class RoomTabsSection extends StatelessWidget {
  final String description;
  final String rules;

  const RoomTabsSection({
    super.key,
    required this.description,
    required this.rules,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Column(
        children: [
            TabBar(
              indicatorColor: theme.colors.secondary,
              labelColor: theme.colors.title,
              unselectedLabelColor: theme.colors.hint,
              indicatorWeight: 2,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: theme.typography.textTheme.labelMedium?.copyWith(
                color: theme.colors.title,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(text: 'About room'),
                Tab(text: 'Room rules'),
              ],
            ),

          SizedBox(
            height: 700,
            child: TabBarView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Text(
                    description,
                    style: theme.typography.textTheme.bodyMedium?.copyWith(
                      color: theme.colors.body,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Text(
                    rules.isNotEmpty
                        ? rules
                        : 'Room rules will appear here soon.',
                    style: theme.typography.textTheme.bodyMedium?.copyWith(
                      color: theme.colors.body,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
