import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/domain/usecase/booking/cancel_booking.dart';
import 'package:share_space/domain/usecase/booking/get_booking_history.dart';

import '../../shared/ui_state/booking_ui_state.dart';
import '../../shared/ui_state/mapper/booking_ui_mapper.dart';
import 'booking_history_state.dart';

class BookingHistoryCubit extends Cubit<BookingHistoryState> {
  final GetBookingHistoryUseCase _getBookingHistoryUseCase;
  final CancelBookingUseCase _cancelBookingUseCase;


  BookingHistoryCubit(this._getBookingHistoryUseCase, this._cancelBookingUseCase)
    : super(BookingHistoryInitial());

  Future<void> fetchBookingHistory() async {
    emit(BookingHistoryLoading());
    try {
      final fullHistory = await _getBookingHistoryUseCase();
      emit(
        BookingHistoryLoaded(
          fullHistory.map((booking) => mapBookingToUiState(booking)).toList(),
          fullHistory
              .map((booking) => mapBookingToUiState(booking))
              .where(
                (element) => element.status == BookingStatusUiState.upcoming,
              )
              .toList(),
          fullHistory
              .map((booking) => mapBookingToUiState(booking))
              .where(
                (element) => element.status == BookingStatusUiState.cancelled,
              )
              .toList(),
          fullHistory
              .map((booking) => mapBookingToUiState(booking))
              .where(
                (element) => element.status == BookingStatusUiState.completed,
              )
              .toList(),
        ),
      );
    } catch (e) {
      emit(BookingHistoryError(e.toString()));
    }
  }

  Future<void> cancelBooking(String bookingId) async {
    _cancelBookingUseCase(bookingId);
      await fetchBookingHistory();
  }

  Future<void> extendBooking() async {}

  Future<void> rateBooking() async {}

  Future<void> onBookAgain() async {}

}
