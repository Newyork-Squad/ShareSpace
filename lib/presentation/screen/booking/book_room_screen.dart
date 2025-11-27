import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/di/injection.dart';
import 'package:share_space/presentation/design_system/colors/app_color.dart';
import 'package:share_space/presentation/screen/booking/state/booking_cubit.dart';
import 'package:share_space/presentation/screen/booking/state/booking_state.dart';
import 'package:share_space/presentation/screen/booking/widgets/calendar_widget.dart';
import 'package:share_space/presentation/screen/booking/widgets/confirm_booking_bottom_sheet.dart';
import 'package:share_space/presentation/screen/booking/widgets/duration_widget.dart';
import 'package:share_space/presentation/screen/booking/widgets/payment_widget.dart';
import 'package:share_space/presentation/screen/booking/widgets/time_slot_widget.dart';
import 'package:share_space/resources/app_strings.dart';
import '../../design_system/widget/share_space_app_button.dart';
import '../../routes/routes.dart';

class BookRoomScreen extends StatelessWidget {
  const BookRoomScreen({super.key, this.roomId});

  final String? roomId;

  @override
  Widget build(BuildContext context) {
    final resolvedRoomId =
        roomId ?? (ModalRoute.of(context)?.settings.arguments as String?) ?? '';

    return BlocProvider(
      create: (context) => getIt<BookingCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.light.surfaceLow,
        appBar: AppBar(
          title: const Text('Book Room'),
          backgroundColor: AppColors.light.surfaceLow,
          surfaceTintColor: AppColors.light.surfaceLow,
          elevation: 0,
        ),
        body: BlocBuilder<BookingCubit, BookingState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CalendarWidget(
                    onDateSelected: (date) {
                      context.read<BookingCubit>().onDateChanged(date);
                    },
                  ),
                  const SizedBox(height: 16),
                  TimeSlotWidget(
                    onStartTimeSelected: (startTime) => context
                        .read<BookingCubit>()
                        .onStartTimeChanged(startTime),
                    onEndTimeSelected: (endTime) =>
                        context.read<BookingCubit>().onEndTimeChanged(endTime),
                  ),
                  const SizedBox(height: 16),
                  DurationWidget(
                    onDurationSelected: (duration) => context
                        .read<BookingCubit>()
                        .onDurationChanged(duration),
                  ),
                  const SizedBox(height: 16),
                  PaymentWidget(
                    onPaymentTypeSelected: (paymentType) => context
                        .read<BookingCubit>()
                        .onPaymentTypeChanged(paymentType),
                  ),
                  const SizedBox(height: 24),
                  ShareSpaceAppButton(
                    isEnabled: context.read<BookingCubit>().isButtonEnabled,
                    text: AppStrings.bookingConfirmBookingButton,
                    onPressed: () {
                      if (context.read<BookingCubit>().isButtonEnabled) {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => BlocProvider.value(
                            value: context.read<BookingCubit>(),
                            child: ConfirmBookingBottomSheet(
                              onConfirm: () {
                                try {
                                  context.read<BookingCubit>().bookRoom(
                                    workspaceId: resolvedRoomId,
                                  );
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Booking confirmed'),
                                    ),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Booking failed. Please try again.',
                                      ),
                                    ),
                                  );
                                }
                              },
                              roomName: "",
                              price: '',
                              date: '',
                              time: '',
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
