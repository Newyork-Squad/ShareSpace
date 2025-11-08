import 'package:dio/dio.dart';

Exception handleError(DioException e) {
  if (e.response != null) {
    final message = e.response?.data['message'] ?? 'Server error occurred';
    return Exception(message);
  } else if (e.type == DioExceptionType.connectionTimeout) {
    return Exception('Connection timeout');
  } else if (e.type == DioExceptionType.receiveTimeout) {
    return Exception('Receive timeout');
  } else if (e.type == DioExceptionType.connectionError) {
    return Exception('No internet connection');
  } else {
    return Exception('Unexpected error occurred');
  }
}
