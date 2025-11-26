import 'package:share_space/domain/entity/booking.dart';

abstract class BookingRepository {
  void bookRoom({
    required String workspaceId,
    required String date,
    required String startTime,
    required double durationHours,
    required String paymentType,
  });
  Future<List<Booking>> getBookingHistory();
}