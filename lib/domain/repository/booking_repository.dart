import 'package:share_space/domain/entity/booking.dart';

abstract class BookingRepository {
  Future<List<Booking>> getBookingHistory();
}