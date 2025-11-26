import 'package:share_space/data/mapper/booking_mapper.dart';
import 'package:share_space/domain/entity/booking.dart';

import '../../domain/repository/booking_repository.dart';
import '../remote/booking_api_service.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingApiService _apiService;

  BookingRepositoryImpl(this._apiService);

  @override
  void bookRoom({
    required String workspaceId,
    required String date,
    required String startTime,
    required double durationHours,
    required String paymentType,
  }){
    try {
      _apiService.bookRoom(
        workspaceId: workspaceId,
        date: date,
        startTime: startTime,
        durationHours: durationHours,
        paymentType: paymentType,
      );
    } catch (e) {
      throw Exception('Failed to book the room: $e');
    }
  }


  @override
  Future<List<Booking>> getBookingHistory() async {
    try {
      final response = await _apiService.getHistory(page: 0, size: 10);
      return response.map((dto) => dto.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to fetch Booking History: $e');
    }
  }
}
