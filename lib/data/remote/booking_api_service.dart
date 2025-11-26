import 'dto/booking_response.dart';

abstract class BookingApiService {

  void bookRoom({
    required String workspaceId,
    required String date,
    required String startTime,
    required double durationHours,
    required String paymentType,
  });

  Future<List<BookingResponse>> getHistory({
    int page = 0,
    int size = 10,
    String status,
  });
}