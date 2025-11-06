import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/presentation/screen/room_details/state/room_details_cubit.dart';
import 'package:share_space/presentation/screen/room_details/state/room_details_state.dart';
import 'package:share_space/presentation/screen/room_details/widgets/room_booking_bar.dart';
import 'package:share_space/presentation/screen/room_details/widgets/room_details_body.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';

class RoomDetailsScreen extends StatelessWidget {
  final String price = '12,000 IQD/h';

  const RoomDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return BlocProvider(
      create: (_) => RoomDetailsCubit()..fetchRoomDetails(),
      child: BlocBuilder<RoomDetailsCubit, RoomDetailsState>(
        builder: (context, state) {
          if (state is RoomDetailsLoading) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: theme.colors.surfaceLow,
                color: theme.colors.yellow,
              ),
            );
          } else if (state is RoomDetailsLoaded) {
            return Scaffold(
              body: RoomDetailsBody(state: state),
              bottomNavigationBar: RoomBookingBar(price: state.price),
            );
          } else if (state is RoomDetailsError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
