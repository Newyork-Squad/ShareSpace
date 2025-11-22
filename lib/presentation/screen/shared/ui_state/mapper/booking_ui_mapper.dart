
import 'package:share_space/domain/entity/booking.dart';
import 'package:share_space/presentation/screen/shared/ui_state/booking_ui_state.dart';
import 'package:share_space/presentation/screen/shared/ui_state/mapper/workspace_ui_mapper.dart';

BookingUiState mapBookingToUiState(Booking booking){
  BookingUiState(
    date: booking.startTime.toString(),
    startTime: booking.startTime.toString(),
    endTime: booking.endTime.toString(),
    status: mapBookingStatusToUiState(booking.status),
    workspace: mapWorkToUiState(booking.w),
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
