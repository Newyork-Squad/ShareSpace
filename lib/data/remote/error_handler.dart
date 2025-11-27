import 'package:dio/dio.dart';

Exception handleError(DioException e) {
  if (e.response != null && e.response?.data != null) {
    final data = e.response!.data;
    String message;

    if (data['errors'] != null && data['errors'] is List) {
      final errors = List<String>.from(data['errors']);
      message = errors.join('\n');
    }
    else if (data['message'] != null) {
      message = data['message'].toString();
    }
    else {
      message = 'Server error occurred';
    }

    return Exception(message);
  }
  else if (e.type == DioExceptionType.connectionTimeout) {
    return Exception('Connection timeout');
  } else if (e.type == DioExceptionType.receiveTimeout) {
    return Exception('Receive timeout');
  } else if (e.type == DioExceptionType.connectionError) {
    return Exception('No internet connection');
  }
  else {
    return Exception('Unexpected error occurred');
  }
}
