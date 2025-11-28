import 'package:share_space/domain/entity/booking.dart';
import 'package:share_space/domain/repository/booking_repository.dart';

class CancelBookingUseCase {
  final BookingRepository _repository;

  CancelBookingUseCase(this._repository);

  Future<void> call(String bookingId) async {
    _repository.cancelBooking(bookingId: bookingId);
  }
}
