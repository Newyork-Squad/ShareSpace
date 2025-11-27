import 'dto/booking_response.dart';

abstract class BookingApiService {
  Future<List<BookingResponse>> getHistory({
    int page = 0,
    int size = 10,
    String status,
  });
}