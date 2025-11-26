import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, BlocProvider;
import 'package:share_space/di/injection.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';
import 'package:share_space/presentation/design_system/widget/booking_card/booking_card.dart';
import 'package:share_space/presentation/design_system/widget/category_chip.dart';
import 'package:share_space/presentation/design_system/widget/loading_screen.dart';
import 'package:share_space/presentation/screen/booking_history/state/booking_history_cubit.dart';
import 'package:share_space/presentation/screen/booking_history/state/booking_history_state.dart';
import 'package:share_space/presentation/screen/shared/ui_state/booking_ui_state.dart';
import 'package:share_space/presentation/screen/shared/ui_state/workspace_ui_state.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({super.key});

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  final List<String> _filterCategories =
      ["All"] + BookingStatusUiState.values.map((e) => e.name).toList();

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return BlocProvider(
      create: (context) => getIt<BookingHistoryCubit>()..fetchBookingHistory(),
      child: BlocBuilder<BookingHistoryCubit, BookingHistoryState>(
        builder: (context, state) {
          if (state is BookingHistoryLoading) {
            return const LoadingScreen();
          } else if (state is BookingHistoryLoaded) {
            return Scaffold(
              backgroundColor: theme.colors.surface,
              appBar: AppBar(
                leading: const SizedBox.shrink(),
                leadingWidth: 0,
                title: Text(
                  "Booking History",
                  style: theme.typography.textTheme.headlineSmall?.copyWith(
                    color: theme.colors.title,
                  ),
                ),
                backgroundColor: theme.colors.surface,
                surfaceTintColor: theme.colors.surface,
                elevation: 0,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _filterCategories.length,
                        itemBuilder: (context, index) {
                          return CategoryChip(
                            label: _filterCategories[index],
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
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.separated(
                        itemCount: _getFilteredBookings(
                          state.selectedIndex,
                          state.all,
                          state.upcoming,
                          state.cancelled,
                          state.completed,
                        ).length,
                        itemBuilder: (context, index) {
                          final booking = _getFilteredBookings(
                            state.selectedIndex,
                            state.all,
                            state.upcoming,
                            state.cancelled,
                            state.completed,
                          )[index];
                          return BookingCard(
                            imageUrl: booking.getImage(),
                            rating: booking.workspace.rate,
                            title: booking.workspace.name,
                            price: "${booking.workspace.pricePerHour}/h",
                            location: booking.workspace.locationName,
                            amenities: booking.workspace.services
                                .map((service) => service.toString())
                                .toList(),
                            status: booking.status,
                            date: booking.date,
                            time: "${booking.startTime} -> ${booking.endTime}",
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is BookingHistoryError) {
            return Center(
              child: Text(
                state.message,
                style: theme.typography.textTheme.labelSmall,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  List<BookingUiState> _getFilteredBookings(
    int selectedIndex,
    List<BookingUiState> allBookings,
    List<BookingUiState> upcoming,
    List<BookingUiState> cancelled,
    List<BookingUiState> completed,
  ) {
    switch (selectedIndex) {
      case 0:
        return allBookings;
      case 1:
        return upcoming;
        case 2:
        return cancelled;
      case 3:
        return completed;
      default:
        return allBookings;
    }
  }
}
