import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, BlocProvider;
import 'package:share_space/di/injection.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';
import 'package:share_space/presentation/design_system/widget/booking_card/booking_card.dart';
import 'package:share_space/presentation/design_system/widget/category_chip.dart';
import 'package:share_space/presentation/design_system/widget/error_screen.dart';
import 'package:share_space/presentation/design_system/widget/loading_screen.dart';
import 'package:share_space/presentation/screen/booking_history/state/booking_history_cubit.dart';
import 'package:share_space/presentation/screen/booking_history/state/booking_history_state.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({super.key});

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  int _selectedIndex = 0;

  final List<BookingCard> _allBookings = [
    BookingCard(
      imageUrl: "https://example.com/image.png",
      rating: 4.5,
      title: "Night Owl Room",
      price: "12,000 IQD/h",
      location: "Baghdad, Iraq",
      amenities: const ["WiFi", "A/C", "Whiteboard", "Power Backup"],
      status: BookingStatus.upcoming,
      date: "27 Jun 2025",
      time: "03:00 PM -> 04:00 PM",
    ),
    BookingCard(
      imageUrl: "https://example.com/image.png",
      rating: 4.8,
      title: "The Sunshine Room",
      price: "15,000 IQD/h",
      location: "Erbil, Iraq",
      amenities: const ["WiFi", "A/C", "Projector"],
      status: BookingStatus.completed,
      date: "15 May 2025",
      time: "10:00 AM -> 12:00 PM",
    ),
    BookingCard(
      imageUrl: "https://example.com/image.png",
      rating: 4.2,
      title: "The Focus Zone",
      price: "10,000 IQD/h",
      location: "Baghdad, Iraq",
      amenities: const ["WiFi", "Power Backup"],
      status: BookingStatus.canceled,
      date: "20 Jun 2025",
      time: "01:00 PM -> 02:00 PM",
    ),
  ];

  final List<String> _filterCategories = [
    "All",
    "Upcoming",
    "Completed",
    "Cancelled",
  ];

  List<BookingCard> get _filteredBookings {
    if (_selectedIndex == 0) {
      return _allBookings;
    }
    final status = BookingStatus.values[_selectedIndex - 1];
    return _allBookings.where((booking) => booking.status == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return BlocProvider(
      create: (context) => getIt<BookingHistoryCubit>()..fetchBookingHistory(),
      child: BlocBuilder<BookingHistoryCubit, BookingHistoryState>(
        builder: (context, state) {
          if (state is BookingHistoryLoading) {
            return LoadingScreen();
          } else if (state is BookingHistoryLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Booking History",
                  style: theme.typography.textTheme.headlineSmall?.copyWith(
                    color: theme.colors.title,
                  ),
                ),
                backgroundColor: theme.colors.surface,
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
                        itemCount: _filteredBookings.length,
                        itemBuilder: (context, index) {
                          return _filteredBookings[index];
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
            // return ErrorScreen(hasAppBar: false);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
