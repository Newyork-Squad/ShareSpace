import '../entity/room_details.dart';

abstract class RoomDetailsRepository {
  Future<RoomDetails> getRoomDetails(String id);
}

