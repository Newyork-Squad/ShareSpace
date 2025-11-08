import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/presentation/screen/home/state/home_cubit.dart';
import 'package:share_space/presentation/screen/home/state/home_state.dart';
import 'package:share_space/presentation/screen/home/widget/booking_card.dart';
import 'package:share_space/presentation/screen/home/widget/category_chip.dart';
import 'package:share_space/presentation/screen/home/widget/home_app_bar.dart';
import 'package:share_space/presentation/screen/home/widget/listing_card.dart';
import 'package:share_space/presentation/screen/home/widget/workspaces_grid.dart';

import '../../../di/injection.dart';
import '../../design_system/theme/app_theme.dart';

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
                      child: FutureBuilder(
                        future: Future.delayed(const Duration(seconds: 2)),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.categories.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    12,
                                    16,
                                    4,
                                    28,
                                  ),
                                  child: BookingCard(
                                    label: state.categories[index].name,
                                    description:
                                        state.categories[index].description,
                                    imageUrl: state.categories[index]
                                        .getImage(),
                                  ),
                                );
                              },
                            );
                          }
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
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        state.categories[state.selectedIndex].name,
                        style: theme.typography.textTheme.titleSmall,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 12)),
                  // Cards
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 320,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: state
                            .categories[state.selectedIndex]
                            .workspaces
                            .length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 4),
                        itemBuilder: (context, index) => SizedBox(
                          width: 328,
                          child: ListingCard(
                            imageUrl: state
                                .categories[state.selectedIndex]
                                .workspaces[index]
                                .imageUrls[0],
                            rating: state
                                .categories[state.selectedIndex]
                                .workspaces[index]
                                .rate,
                            title: state
                                .categories[state.selectedIndex]
                                .workspaces[index]
                                .name,
                            price: state
                                .categories[state.selectedIndex]
                                .workspaces[index]
                                .pricePerHour
                                .toInt()
                                .toString(),
                            location: state
                                .categories[state.selectedIndex]
                                .workspaces[index]
                                .locationName,
                            amenities: state
                                .categories[state.selectedIndex]
                                .workspaces[index]
                                .services
                                .map((e) => e.name)
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is HomeError) {
            return Center(
              child: Text(
                "Please Check your connection", //state.message,
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
