import 'package:flutter/material.dart';
import 'package:share_space/presentation/screen/search/widget/search_field.dart';

import '../../design_system/theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: const SizedBox.shrink(),
          leadingWidth: 0,
          title: Text(
            "Search",
            style: theme.typography.textTheme.titleMedium?.copyWith(
              color: theme.colors.title,
            ),
          ),
          backgroundColor: theme.colors.surface,
          surfaceTintColor: theme.colors.surface,
          elevation: 0,
        ),
        SliverToBoxAdapter(
          child: SearchField(suggestions: [], history: []),
        ),
        SliverToBoxAdapter(child: Container(height: 500, color: Colors.red)),
        SliverToBoxAdapter(child: Container(height: 500, color: Colors.black)),
        SliverToBoxAdapter(child: Container(height: 500, color: Colors.blue)),
      ],
    );
  }
}
