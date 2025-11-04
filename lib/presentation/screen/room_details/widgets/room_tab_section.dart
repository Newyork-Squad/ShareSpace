import 'package:flutter/material.dart';
import '../../../design_system/theme/app_theme.dart';

class RoomTabsSection extends StatelessWidget {
  final String description;

  const RoomTabsSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            indicatorColor: theme.colors.secondary,
            labelColor: theme.colors.title,
            unselectedLabelColor: theme.colors.hint,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Text(
                      description,
                      style: theme.typography.textTheme.bodyMedium?.copyWith(
                        color: theme.colors.body,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                const Center(child: Text('Room rules will appear here soon.')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
