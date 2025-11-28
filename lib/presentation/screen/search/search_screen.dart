import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/presentation/screen/search/state/search_cubit.dart';
import 'package:share_space/presentation/screen/search/state/search_state.dart';
import 'package:share_space/presentation/screen/search/widget/search_field.dart';

import '../../../di/injection.dart';
import '../../design_system/theme/app_theme.dart';
import '../../design_system/widget/error_screen.dart';
import '../../design_system/widget/loading_screen.dart';
import '../../design_system/widget/workspace_details_card.dart';
import '../../routes/routes.dart';
import '../../util/service_mapper.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return BlocProvider(
      create: (context) => getIt<SearchCubit>()..fetchLastViewed(),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return LoadingScreen();
          } else if (state is SearchLoaded) {
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
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: state.lastViewed
                        .map(
                          (room) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.roomDetailsScreen,
                                      arguments: room.id.toString(),
                                    );
                                  },
                                  child: WorkspaceDetailsCard(
                                    title: room.name,
                                    imageUrl: room.imageUrls.isNotEmpty
                                        ? room.imageUrls[0]
                                        : '',
                                    rating: room.rate,
                                    price:
                                        "${room.pricePerHour.toInt().toString()}/h",
                                    location: room.locationName,
                                    amenities: room.services
                                        .map((e) => e.name)
                                        .toList(),
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            );
          } else if (state is SearchError) {
            return ErrorScreen(hasAppBar: false);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
