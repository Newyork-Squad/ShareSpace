import 'package:share_space/domain/entity/booking.dart';
import 'package:share_space/domain/repository/booking_repository.dart';


class GetBookingHistoryUseCase {
  final BookingRepository _repository;

  GetBookingHistoryUseCase(this._repository);

  Future<List<Booking>> call() {
    return _repository.getBookingHistory();
  }
}
