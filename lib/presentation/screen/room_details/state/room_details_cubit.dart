import 'package:share_space/presentation/screen/room_details/widgets/room_header_section.dart';
import 'package:share_space/presentation/screen/room_details/state/room_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomDetailsCubit extends Cubit<RoomDetailsState> {
  RoomDetailsCubit() : super(RoomDetailsInitial());

  Future<void> fetchRoomDetails() async {
    emit(RoomDetailsLoading());

    try {
      await Future.delayed(const Duration(seconds: 1));

      emit(RoomDetailsLoaded(
        roomImages: const [
          'assets/images/room_image.png',
          'assets/images/room_image.png',
          'assets/images/room_image.png',
          'assets/images/room_image.png',
        ],
        roomName:'Modern study room',
        location:'Baghdad, Iraq',
        services: [
          Service(name: 'WiFi', imagePath: 'assets/icons/wifi.svg'),
          Service(name: 'whiteboard', imagePath: 'assets/icons/whiteboard.svg'),
          Service(name: 'power backup', imagePath: 'assets/icons/power_backup.svg'),
          Service(name: 'A/C', imagePath: 'assets/icons/ac.svg'),
        ],
        ownerName: 'Ali Kareem Mohammed',
        ownerRole: 'Owner',
        ownerImagePath: 'assets/images/owner.png',
        roomDescription: '''
A modern study room equipped with everything you need for an ideal study experience.
It features comfortable desks, optimal lighting, fully air-conditioned rooms, fast Wi-Fi, and a smart writing tablet for jotting down notes and ideas.
The calming atmosphere helps you focus and accomplish your goals, whether you're studying alone or in a group.
The location is close to public facilities, with easy access and convenient parking.
The room can be booked by the hour, with the option to extend the time directly through the app. A modern study room equipped with everything you need for an ideal study experience.
It features comfortable desks, optimal lighting, fully air-conditioned rooms, fast Wi-Fi, and a smart writing tablet for jotting down notes and ideas.
The calming atmosphere helps you focus and accomplish your goals, whether you're studying alone or in a group.
The location is close to public facilities, with easy access and convenient parking.
The room can be booked by the hour, with the option to extend the time directly through the app.
''',
        price: '12,000 IQD/h',
        rate: '5',
        currentImageIndex: 0,
        isScrolled: false,
      ));
    } catch (e) {
      emit(RoomDetailsError('Failed to load room details.'));
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
}