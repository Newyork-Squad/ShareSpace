import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/di/injection.dart';
import 'package:share_space/presentation/design_system/colors/app_color.dart';
import 'package:share_space/presentation/design_system/widget/custom_top_snackbar.dart';
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
      create: (context) => getIt<BookingCubit>()..fetchRoomDetails(resolvedRoomId),
      child: Scaffold(
        backgroundColor: AppColors.light.surfaceLow,
        appBar: AppBar(
          title: const Text('Book Room'),
          backgroundColor: AppColors.light.surfaceLow,
          surfaceTintColor: AppColors.light.surfaceLow,
          elevation: 0,
        ),
        body: BlocConsumer<BookingCubit, BookingState>(
          listener: (context, state) {
            if (state is BookingSuccess) {
              Navigator.pop(context);
              Navigator.pop(context);
              CustomTopSnackBar.show(
                context,
                title: AppStrings.success,
                message: AppStrings.successBooking,
                isError: false,
              );
            }
            if (state is BookingError) {
              CustomTopSnackBar.show(
                context,
                title: AppStrings.oops,
                message: state.message,
                isError: true,
              );
            }
          },
          builder: (context, state) {
            if (state is BookingLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is BookingFormState) {
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
                      onEndTimeSelected: (endTime) => context
                          .read<BookingCubit>()
                          .onEndTimeChanged(endTime),
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
                      isEnabled: state.isButtonEnabled,
                      text: AppStrings.bookingConfirmBookingButton,
                      onPressed: () {
                        if (state.isButtonEnabled) {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) => BlocProvider.value(
                              value: context.read<BookingCubit>(),
                              child: ConfirmBookingBottomSheet(
                                onConfirm: () {
                                  context.read<BookingCubit>().bookRoom(
                                    workspaceId: resolvedRoomId,
                                  );
                                },
                                roomName: state.roomName,
                                price: state.formattedTotalPrice,
                                date: state.date ?? '',
                                time: state.startTime ?? '',
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
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}