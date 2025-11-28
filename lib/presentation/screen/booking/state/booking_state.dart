
import '../../../../domain/entity/room_details.dart';

abstract class BookingState {
  const BookingState();

  @override
  List<Object?> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingFormState extends BookingState {
  final RoomDetails? roomDetails;
  final String? date;
  final String? startTime;
  final double? durationHours;
  final String paymentType;

  const BookingFormState({
    this.roomDetails,
    this.date,
    this.startTime,
    this.durationHours,
    this.paymentType = "CASH",
  });

  BookingFormState copyWith({
    RoomDetails? roomDetails,
    String? date,
    String? startTime,
    String? endTime,
    double? durationHours,
    String? paymentType,
  }) {
    return BookingFormState(
      roomDetails: roomDetails ?? this.roomDetails,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      durationHours: durationHours ?? this.durationHours,
      paymentType: paymentType ?? this.paymentType,
    );
  }
  double get _totalPrice {
    if (durationHours == null || roomDetails == null) return 0.0;
    return durationHours! * roomDetails!.pricePerHour;
  }
  String get formattedTotalPrice => _totalPrice.toStringAsFixed(2);
  String get roomName => roomDetails?.name ?? '';
  bool get isButtonEnabled {
    return date != null &&
        startTime != null &&
        durationHours != null &&
        roomDetails != null;
  }

  @override
  List<Object?> get props =>
      [date, startTime, durationHours, paymentType];
}

class BookingSuccess extends BookingState {}

class BookingError extends BookingState {
  final String message;

  const BookingError(this.message);

  @override
  List<Object> get props => [message];
}
