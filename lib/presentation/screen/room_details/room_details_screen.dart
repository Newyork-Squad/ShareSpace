import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/di/injection.dart';
import 'package:share_space/domain/usecase/room_details/get_room_details.dart';
import 'package:share_space/domain/usecase/workspace/remove_saved_workspace.dart';
import 'package:share_space/domain/usecase/workspace/save_workspace.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';
import 'package:share_space/presentation/design_system/widget/error_screen.dart';
import 'package:share_space/presentation/design_system/widget/loading_screen.dart';
import 'package:share_space/presentation/screen/room_details/state/room_details/room_details_cubit.dart';
import 'package:share_space/presentation/screen/room_details/state/room_details/room_details_state.dart';
import 'package:share_space/presentation/screen/room_details/state/save_room/save_room_cubit.dart';
import 'package:share_space/presentation/screen/room_details/state/save_room/save_room_state.dart';
import 'package:share_space/presentation/screen/room_details/widgets/room_booking_bar.dart';
import 'package:share_space/presentation/screen/room_details/widgets/room_details_body.dart';
import 'package:share_space/presentation/design_system/widget/custom_top_snackbar.dart';

class RoomDetailsScreen extends StatelessWidget {
  const RoomDetailsScreen({super.key, this.roomId});

  final String? roomId;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final resolvedRoomId = roomId ??
        (ModalRoute.of(context)?.settings.arguments as String?) ??
        '';

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RoomDetailsCubit(getIt<GetRoomDetailsUseCase>())
            ..fetchRoomDetails(resolvedRoomId),
        ),
        BlocProvider(
          create: (_) => SaveRoomCubit(
            saveWorkspaceUseCase: getIt<SaveWorkspaceUseCase>(),
            removeSavedWorkspaceUseCase: getIt<RemoveSavedWorkspaceUseCase>(),
            initiallySaved: false,
          ),
        ),
      ],
      child: BlocListener<SaveRoomCubit, SaveRoomState>(
        listenWhen: (previous, current) =>
        previous.isLoading == true && current.isLoading == false,
        listener: (context, saveState) {
          if (saveState.error != null) {
            CustomTopSnackBar.show(
              context,
              title: 'Error',
              message: saveState.error!,
              isError: true,
            );
          } else {
            CustomTopSnackBar.show(
              context,
              title: 'Success',
              message: saveState.isSaved
                  ? 'Saved room successfully.'
                  : 'Removed room from Saved Workspaces',
              isError: false,
            );
          }
        },
      child: BlocBuilder<RoomDetailsCubit, RoomDetailsState>(
        builder: (context, state) {
          if (state is RoomDetailsLoading) {
            return LoadingScreen();
          }

          if (state is RoomDetailsLoaded) {
            return Scaffold(
              body: RoomDetailsBody(
                  state: state,
                  roomId: resolvedRoomId,
                ),
              bottomNavigationBar: RoomBookingBar(price: state.price, roomId: '',),
            );
          }

          if (state is RoomDetailsError) {
            return ErrorScreen();
          }

          return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
