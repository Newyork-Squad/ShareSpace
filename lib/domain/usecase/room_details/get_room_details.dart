import '../../entity/room_details.dart';
import '../../repository/room_details_repository.dart';

class GetRoomDetailsUseCase {
  final RoomDetailsRepository _repository;

  GetRoomDetailsUseCase(this._repository);

  Future<RoomDetails> call(String id) {
    return _repository.getRoomDetails(id);
  }
}

