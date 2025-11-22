import 'package:share_space/presentation/screen/shared/booking_ui_state.dart';

abstract class BookingHistoryState {}

class BookingHistoryInitial extends BookingHistoryState {}

class BookingHistoryLoading extends BookingHistoryState {}

class BookingHistoryLoaded extends BookingHistoryState {
  final List<BookingUiState> upcoming;
  final List<BookingUiState> cancelled;
  final List<BookingUiState> completed;
  int selectedIndex = 0;

  BookingHistoryLoaded(this.upcoming, this.cancelled, this.completed);
}

class BookingHistoryError extends BookingHistoryState {
  final String message;

  BookingHistoryError(this.message);
}
