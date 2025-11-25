import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/presentation/design_system/widget/error_screen.dart';
import 'package:share_space/presentation/design_system/widget/loading_screen.dart';
import 'package:share_space/presentation/design_system/widget/workspace_card_details.dart';
import 'package:share_space/presentation/screen/home/state/home_cubit.dart';
import 'package:share_space/presentation/screen/home/state/home_state.dart';
import 'package:share_space/presentation/screen/home/widget/booking_card.dart';
import 'package:share_space/presentation/screen/home/widget/category_chip.dart';
import 'package:share_space/presentation/screen/home/widget/home_app_bar.dart';
import 'package:share_space/presentation/screen/home/widget/workspaces_grid.dart';
import 'package:share_space/presentation/util/service_mapper.dart';

import '../../../di/injection.dart';
import '../../design_system/theme/app_theme.dart';
import '../../design_system/widget/see_all_bar.dart';
import '../../routes/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Material(
      color: theme.colors.surfaceLow,
      child: BlocProvider(
        create: (context) => getIt<HomeCubit>()..fetchHome(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return LoadingScreen();
            } else if (state is HomeLoaded) {
              return Container(
                color: theme.colors.surfaceLow,
                child: CustomScrollView(
                  slivers: [
                    HomeAppBar(
                      userName: state.userName,
                      location: state.location,
                      profileImageUrl: state.userImageUrl ?? "tempImage",
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 16)),
                    // Book now section
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 172,
                        width: 320,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.categories.length,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return const SizedBox.shrink();
                            }
                            return BookingCard(
                              label: state.categories[index].name,
                              description: state.categories[index].description,
                              imageUrl: state.categories[index].getImage(),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            if (index == 0) return const SizedBox(width: 0);
                            return const SizedBox(width: 16);
                          },
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 16)),
                    // Chips row
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 40,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          scrollDirection: Axis.horizontal,
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) {
                            return CategoryChip(
                              label: state.categories[index].name,
                              isSelected: state.selectedIndex == index,
                              onTap: () {
                                setState(() {
                                  state.selectedIndex = index;
                                });
                              },
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 8),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 12)),
                    // Cards
                    SliverToBoxAdapter(
                      child: state.selectedIndex == 0
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: state.categories
                                  .where(
                                    (category) =>
                                        (category.workspaces.isNotEmpty),
                                  )
                                  .expand(
                                    (category) => [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: SeeAllBar(
                                          title: category.name,
                                          onAllTap: () {},
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      WorkspacesGrid(
                                        onClick: (roomId) {
                                          Navigator.pushNamed(
                                            context,
                                            Routes.roomDetailsScreen,
                                            arguments: roomId,
                                          );
                                        },
                                        category: category,
                                      ),
                                    ],
                                  )
                                  .toList(),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Text(
                                    state.categories[state.selectedIndex].name,
                                    style: theme.typography.textTheme.titleSmall
                                        ?.copyWith(color: theme.colors.title),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                WorkspacesGrid(
                                  onClick: (roomId) {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.roomDetailsScreen,
                                      arguments: roomId,
                                    );
                                  },
                                  category:
                                      state.categories[state.selectedIndex],
                                ),
                              ],
                            ),
                    ),
                    if (state.featured.isNotEmpty) ...[
                      const SliverToBoxAdapter(child: SizedBox(height: 20)),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "Featured places",
                            style: theme.typography.textTheme.titleSmall
                                ?.copyWith(color: theme.colors.title),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: const SizedBox(height: 12)),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: state.featured
                              .map(
                                (room) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            Routes.roomDetailsScreen,
                                            arguments: room.id.toString(),
                                          );
                                        },
                                        child: WorkspaceCardDetails(
                                          title: room.name,
                                          imageUrl: room.imageUrls.isNotEmpty
                                              ? room.imageUrls[0]
                                              : '',
                                          rating: room.rate,
                                          price:
                                              "${room.pricePerHour.toInt().toString()}/h",
                                          location: room.locationName,
                                          amenities: room.services
                                              .map((e) => serviceLabel(e))
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
                  ],
                ),
              );
            } else if (state is HomeError) {
              return ErrorScreen(hasAppBar: false);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
