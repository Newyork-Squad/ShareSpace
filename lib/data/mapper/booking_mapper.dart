import 'dart:convert';

import 'package:share_space/data/mapper/workspace_mapper.dart';
import 'package:share_space/data/remote/dto/booking_response.dart';
import 'package:share_space/domain/entity/booking.dart';


extension BookingResponseMapper on BookingResponse {
  Booking toEntity() {
    return Booking(
      id: id,
      workspace: workspace.mapToEntity(),
      userId: userId,
      startTime: startTime,
      endTime: endTime,
      duration: duration,
      paymentType: paymentType,
      cost: cost,
      status: toBookingStatus(status),
      paymentStatus: paymentStatus,
    );
  }
}

BookingStatus toBookingStatus(String status) {
  return switch (status) {
    'upcoming' => BookingStatus.upcoming,
    'completed' => BookingStatus.completed,
    'canceled' => BookingStatus.canceled,
    _ => throw Exception('Invalid booking status: $status'),
  };
}

List<BookingResponse> listFromJson(dynamic data) {
  if (data is List) {
    return data.map((e) => BookingResponse.fromJson(e)).toList();
  } else if (data is String) {
    return (jsonDecode(data) as List)
        .map((e) => BookingResponse.fromJson(e))
        .toList();
  } else {
    return [];
  }
}
