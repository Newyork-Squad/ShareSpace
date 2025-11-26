import 'package:share_space/presentation/screen/shared/ui_state/booking_ui_state.dart';

abstract class BookingHistoryState {}

class BookingHistoryInitial extends BookingHistoryState {}

class BookingHistoryLoading extends BookingHistoryState {}

class BookingHistoryLoaded extends BookingHistoryState {
  final List<BookingUiState> all;
  final List<BookingUiState> upcoming;
  final List<BookingUiState> cancelled;
  final List<BookingUiState> completed;
  int selectedIndex = 0;

  BookingHistoryLoaded(this.all, this.upcoming, this.cancelled, this.completed);
}

class BookingHistoryError extends BookingHistoryState {
  final String message;

  BookingHistoryError(this.message);
}
