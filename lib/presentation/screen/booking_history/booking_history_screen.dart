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
  int _selectedIndex = 0;

  final List<String> _filterCategories = [
        "All"
      ] +
      BookingStatusUiState.values.map((e) => e.name).toList();

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
            final allBookings =
                state.upcoming + state.completed + state.cancelled;
            final filteredBookings = _getFilteredBookings(allBookings);

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
                            isSelected: _selectedIndex == index,
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
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
                        itemCount: filteredBookings.length,
                        itemBuilder: (context, index) {
                          final booking = filteredBookings[index];
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

  List<BookingUiState> _getFilteredBookings(List<BookingUiState> allBookings) {
    if (_selectedIndex == 0) {
      return allBookings;
    }
    final status = BookingStatusUiState.values[_selectedIndex - 1];
    return allBookings.where((booking) => booking.status == status).toList();
  }
}