import 'package:dio/dio.dart';

import '../mapper/booking_mapper.dart';
import 'booking_api_service.dart';
import 'dto/booking_response.dart';
import 'error_handler.dart';

class BookingApiServiceImpl extends BookingApiService {
  final Dio _dio;

  BookingApiServiceImpl(this._dio);

  @override
  void bookRoom({
    required String workspaceId,
    required String date,
    required String startTime,
    required double durationHours,
    required String paymentType,
  }) {
    try {
      _dio.post(
        '/bookings/book',
        data: {
          'workspaceId': workspaceId,
          'date': date,
          'startTime': startTime,
          'durationHours': durationHours,
          'paymentType': paymentType,
        },
      );
    } on DioException catch (e) {
      throw handleError(e);
    }
  }

  @override
  Future<List<BookingResponse>> getHistory({
    int page = 0,
    int size = 10,
    String status = "",
  }) async {
    try {
      final response = await _dio.get(
        '/bookings/history',
        queryParameters: {'page': page, 'size': size, 'status': status},
        options: Options(extra: {'forceRefresh': true}),
      );
      if (response.data['success'] == true) {
        return listFromJson(response.data['data']['content']);
      }

      throw Exception(
        response.data['message'] ?? 'Failed to fetch booking history',
      );
    } on DioException catch (e) {
      throw handleError(e);
    }
  }

  @override
  Future<void> cancelBooking({required String bookingId}) async {
    try {
      final uuidRegExp = RegExp(
        r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$',
      );
      if (!uuidRegExp.hasMatch(bookingId)) {
        throw ArgumentError.value(bookingId, 'bookingId', 'Invalid UUID');
      }
      final response = await _dio.put(
        '/bookings/$bookingId/cancel',
        queryParameters: {'bookingId': bookingId},
      );
      if (response.data['success'] == true) {
        return;
      }
      throw Exception(
        response.data['message'] ?? 'Failed to fetch booking history',
      );
    } on DioException catch (e) {
      throw handleError(e);
    }
  }

}
