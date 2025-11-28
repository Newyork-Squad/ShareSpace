
abstract class BookingState {
  const BookingState();

  @override
  List<Object?> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingFormState extends BookingState {
  final String? date;
  final String? startTime;
  final double? durationHours;
  final String paymentType;

  const BookingFormState({
    this.date,
    this.startTime,
    this.durationHours,
    this.paymentType = "CASH",
  });

  BookingFormState copyWith({
    String? date,
    String? startTime,
    String? endTime,
    double? durationHours,
    String? paymentType,
  }) {
    return BookingFormState(
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      durationHours: durationHours ?? this.durationHours,
      paymentType: paymentType ?? this.paymentType,
    );
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
