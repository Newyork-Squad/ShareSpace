import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecase/booking/book_room.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookRoomUseCase _bookRoomUseCase;

  BookingCubit(this._bookRoomUseCase) : super(const BookingFormState());

  void onDateChanged(DateTime date) {
    final currentState = state;
    if (currentState is BookingFormState) {
      emit(currentState.copyWith(date: date.toIso8601String()));
    }
  }

  void onStartTimeChanged(String startTime) {
    final currentState = state;
    if (currentState is BookingFormState) {
      emit(currentState.copyWith(startTime: startTime));
    }
  }

  void onEndTimeChanged(String endTime) {
    final currentState = state;
    if (currentState is BookingFormState) {
      emit(currentState.copyWith(endTime: endTime));
    }
  }

  void onDurationChanged(double duration) {
    final currentState = state;
    if (currentState is BookingFormState) {
      emit(currentState.copyWith(durationHours: duration));
    }
  }

  void onPaymentTypeChanged(String paymentType) {
    final currentState = state;
    if (currentState is BookingFormState) {
      emit(currentState.copyWith(paymentType: paymentType));
    }
  }

  bool get isButtonEnabled {
    final currentState = state;
    if (currentState is BookingFormState) {
      return currentState.date != null &&
          currentState.startTime != null &&
          currentState.durationHours != null;
    }
    return false;
  }

  void bookRoom({required String workspaceId}) async {
    final currentState = state;
    if (currentState is BookingFormState) {
      emit(BookingLoading());
      try {
        _bookRoomUseCase.call(
          workspaceId: workspaceId,
          date: currentState.date!,
          startTime: currentState.startTime!,
          durationHours: currentState.durationHours!,
          paymentType: currentState.paymentType,
        );
        emit(BookingSuccess());
      } catch (e) {
        emit(BookingError(e.toString()));
      }
    }
  }
}
