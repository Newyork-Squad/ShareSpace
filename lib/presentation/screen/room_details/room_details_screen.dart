import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/di/injection.dart';
import 'package:share_space/domain/usecase/room_details/get_room_details.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';
import 'package:share_space/presentation/design_system/widget/loading_screen.dart';
import 'package:share_space/presentation/screen/room_details/state/room_details/room_details_cubit.dart';
import 'package:share_space/presentation/screen/room_details/state/room_details/room_details_state.dart';
import 'package:share_space/presentation/screen/room_details/widgets/room_booking_bar.dart';
import 'package:share_space/presentation/screen/room_details/widgets/room_details_body.dart';

class RoomDetailsScreen extends StatelessWidget {
  const RoomDetailsScreen({super.key, this.roomId});

  final String? roomId;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final resolvedRoomId = roomId ??
        (ModalRoute.of(context)?.settings.arguments as String?) ??
        '';

    return BlocProvider(
      create: (_) => RoomDetailsCubit(getIt<GetRoomDetailsUseCase>())
        ..fetchRoomDetails(resolvedRoomId),
      child: BlocBuilder<RoomDetailsCubit, RoomDetailsState>(
        builder: (context, state) {
          if (state is RoomDetailsLoading) {
            return LoadingScreen();
          }

          if (state is RoomDetailsLoaded) {
            return Scaffold(
              body: RoomDetailsBody(state: state),
              bottomNavigationBar: RoomBookingBar(price: state.price),
            );
          }

          if (state is RoomDetailsError) {
            return Scaffold(
              body: Center(
                child: Text(
                  state.message,
                  style: theme.typography.textTheme.bodyMedium
                      ?.copyWith(color: theme.colors.title),
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
