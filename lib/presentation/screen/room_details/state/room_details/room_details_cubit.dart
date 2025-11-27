import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/domain/usecase/room_details/get_room_details.dart';
import 'package:share_space/presentation/screen/room_details/state/room_details/room_details_state.dart';
import 'package:share_space/presentation/util/formatters.dart';
import 'package:share_space/presentation/util/service_mapper.dart';

class RoomDetailsCubit extends Cubit<RoomDetailsState> {
  RoomDetailsCubit(this._getRoomDetailsUseCase) : super(RoomDetailsInitial());

  final GetRoomDetailsUseCase _getRoomDetailsUseCase;

  Future<void> fetchRoomDetails(String roomId) async {
    if (roomId.isEmpty) {
      emit(RoomDetailsError('Room identifier is missing.'));
      return;
    }

    emit(RoomDetailsLoading());

    try {
      final details = await _getRoomDetailsUseCase(roomId);
      emit(
        RoomDetailsLoaded(
          roomImages: details.imageUrls.isNotEmpty
              ? details.imageUrls
              : _fallbackImages,
          roomName: details.name,
          location: details.locationName,
          services: mapServicesToPresentation(details.services),
          ownerName: details.owner?.name ?? 'Room owner',
          ownerRole: details.owner?.role ?? 'Owner',
          ownerImagePath:
              details.owner?.avatarUrl ?? 'assets/images/owner.png',
          roomDescription: details.description,
          roomRules: details.rules,
          price: formatHourlyPrice(details.pricePerHour),
          rate: formatRating(details.rating),
          currentImageIndex: 0,
          isScrolled: false,
        ),
      );
    } catch (error) {
      final message = error.toString().replaceFirst('Exception: ', '');
      emit(RoomDetailsError(message.isEmpty
          ? 'Failed to load room details.'
          : message));
    }
  }

  void changeImageIndex(int index) {
    final currentState = state;
    if (currentState is RoomDetailsLoaded) {
      emit(currentState.copyWith(currentImageIndex: index));
    }
  }

  void updateScroll(bool isScrolled) {
    final currentState = state;
    if (currentState is RoomDetailsLoaded) {
      emit(currentState.copyWith(isScrolled: isScrolled));
    }
  }

  static const List<String> _fallbackImages = [
    'assets/images/room_image.png',
  ];
}
