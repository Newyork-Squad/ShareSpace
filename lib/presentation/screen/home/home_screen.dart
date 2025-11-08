import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/presentation/screen/home/state/home_cubit.dart';
import 'package:share_space/presentation/screen/home/state/home_state.dart';
import 'package:share_space/presentation/screen/home/widget/booking_card.dart';
import 'package:share_space/presentation/screen/home/widget/category_chip.dart';
import 'package:share_space/presentation/screen/home/widget/home_app_bar.dart';
import 'package:share_space/presentation/screen/home/widget/workspaces_grid.dart';

import '../../../di/injection.dart';
import '../../design_system/theme/app_theme.dart';
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
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..fetchHome(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppTheme.of(context).colors.primary,
              ),
            );
          } else if (state is HomeLoaded) {
            return Container(
              color: theme.colors.surfaceLow,
              child: CustomScrollView(
                slivers: [
                  HomeAppBar(
                    userName: "Ahmed Hussein",
                    location: "Cairo, Egypt",
                    profileImageUrl: "tempImage",
                  ),
                  // Book now section
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 172,
                      width: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0 || index == 1) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(12, 16, 4, 28),
                            child: BookingCard(
                              label: state.categories[index].name,
                              description: state.categories[index].description,
                              imageUrl: state.categories[index].getImage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
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
                            const SizedBox(height: 8, width: 8),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),

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
                                      child: Text(
                                        category.name,
                                        style: theme
                                            .typography
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              color: theme.colors.title,
                                            ),
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
                                category: state.categories[state.selectedIndex],
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            );
          } else if (state is HomeError) {
            return Center(
              child: Text(
                "Please Check your internet connection", //state.message,
                style: theme.typography.textTheme.labelSmall,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
