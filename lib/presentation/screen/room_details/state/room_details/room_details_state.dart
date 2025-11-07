import 'package:share_space/presentation/screen/room_details/widgets/room_header_section.dart';

abstract class RoomDetailsState {}

class RoomDetailsInitial extends RoomDetailsState {}

class RoomDetailsLoading extends RoomDetailsState {}

class RoomDetailsLoaded extends RoomDetailsState {
  final List<String> roomImages;
  final String roomName;
  final String location;
  final List<Service> services;
  final String ownerName;
  final String ownerRole;
  final String ownerImagePath;
  final String roomDescription;
  final String price;
  final String rate;
  final int currentImageIndex;
  final bool isScrolled;

  RoomDetailsLoaded({
    required this.roomImages,
    required this.roomName,
    required this.location,
    required this.services,
    required this.ownerName,
    required this.ownerRole,
    required this.ownerImagePath,
    required this.roomDescription,
    required this.price,
    required this.rate,
    required this.currentImageIndex,
    required this.isScrolled,
  });

  RoomDetailsLoaded copyWith({
    List<String>? roomImages,
    String? roomName,
    String? location,
    List<Service>? services,
    String? ownerName,
    String? ownerRole,
    String? ownerImagePath,
    String? roomDescription,
    String? price,
    String? rate,
    int? currentImageIndex,
    bool? isScrolled,
  }) {
    return RoomDetailsLoaded(
      roomImages: roomImages ?? this.roomImages,
      roomName: roomName ?? this.roomName,
      location: location ?? this.location,
      services: services ?? this.services,
      ownerName: ownerName ?? this.ownerName,
      ownerRole: ownerRole ?? this.ownerRole,
      ownerImagePath: ownerImagePath ?? this.ownerImagePath,
      roomDescription: roomDescription ?? this.roomDescription,
      price: price ?? this.price,
      rate: rate ?? this.rate,
      currentImageIndex: currentImageIndex ?? this.currentImageIndex,
      isScrolled: isScrolled ?? this.isScrolled,
    );
  }
}

class RoomDetailsError extends RoomDetailsState {
  final String message;
  RoomDetailsError(this.message);
}
