import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecase/booking/book_room.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookRoomUseCase _bookRoomUseCase;

  BookingCubit(this._bookRoomUseCase) : super(const BookingFormState());

  void onDateChanged(DateTime date) {
    final currentState = state;
    if (currentState is BookingFormState) {
      emit(currentState.copyWith(date: date.toIso8601String().split('T').first));
    }
  }

  void onStartTimeChanged(String startTime) {
    final currentState = state;
    if (currentState is BookingFormState) {
      String result = startTime;
      try {
        final s = startTime.trim();
        final reg = RegExp(r'^(\d{1,2}):(\d{2})(?:\s*([AaPp][Mm]))?$');
        final m = reg.firstMatch(s);
        if (m != null) {
          int hour = int.parse(m.group(1)!);
          final int minute = int.parse(m.group(2)!);
          final ampm = m.group(3);
          if (ampm != null) {
            final isPm = ampm.toLowerCase() == 'pm';
            if (isPm && hour < 12) hour += 12;
            if (!isPm && hour == 12) hour = 0;
          }
          result = hour.toString().padLeft(2, '0') + ':' + minute.toString().padLeft(2, '0');
        }
      } catch (_) {
        // keep original if parsing fails
      }
      emit(currentState.copyWith(startTime: result));
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
