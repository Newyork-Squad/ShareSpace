import 'package:share_space/domain/entity/booking.dart';
import 'package:share_space/domain/repository/booking_repository.dart';
class BookRoomUseCase {
  final BookingRepository _repository;

  BookRoomUseCase(this._repository);

  void call({
    required String workspaceId,
    required String date,
    required String startTime,
    required double durationHours,
    required String paymentType,
  }) {
    return _repository.bookRoom(
      workspaceId: workspaceId,
      date: date,
      startTime: startTime,
      durationHours: durationHours,
      paymentType: paymentType,
    );
  }
}
