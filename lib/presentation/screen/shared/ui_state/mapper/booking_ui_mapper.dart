
import 'package:share_space/domain/entity/booking.dart';
import 'package:share_space/presentation/screen/shared/ui_state/booking_ui_state.dart';
import 'package:share_space/presentation/screen/shared/ui_state/mapper/workspace_ui_mapper.dart';
import 'package:share_space/presentation/util/formatters.dart';

BookingUiState mapBookingToUiState(Booking booking){
  return BookingUiState(
    date: formatDate(booking.startTime),
    startTime: formatTime(booking.startTime),
    endTime: formatTime(booking.endTime),
    status: mapBookingStatusToUiState(booking.status),
    workspace: mapWorkToUiState(booking.workspace),
  );
}

BookingStatusUiState mapBookingStatusToUiState(BookingStatus status){
  switch(status){
    case BookingStatus.upcoming:
      return
          BookingStatusUiState.upcoming;
    case BookingStatus.completed:
      return
          BookingStatusUiState.completed;
    case BookingStatus.canceled:
      return
          BookingStatusUiState.canceled;
  }
}


