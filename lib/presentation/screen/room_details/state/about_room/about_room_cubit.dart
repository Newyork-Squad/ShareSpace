import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/presentation/screen/room_details/state/about_room/about_room_state.dart';

class AboutRoomCubit extends Cubit<AboutRoomState> {
  AboutRoomCubit() : super(AboutRoomInitial());

  Future<void> loadRoomDetails() async {
    emit(AboutRoomLoading());

    try {
      // fake data for now
      final fakeData = RoomDetailsData(
        overallRating: 4.0,
        totalReviews: 122,
        ratingDistribution: {
          5: 0.8,
          4: 0.6,
          3: 0.4,
          2: 0.2,
          1: 0.1,
        },
        reviews: List.generate(10, (index) => ReviewModel(
          reviewerName: 'Hamsa Ali Hussain',
          reviewerImage: 'assets/images/owner.png',
          reviewDate: '12-04-2024',
          rating: 5,
          reviewText: 'Cozy and quiet workspace! WiFi was fast, comfy chairs.',
        )),
      );

      emit(AboutRoomLoaded(fakeData));
    } catch (e) {
      emit(AboutRoomError('Failed to load room details'));
    }
  }
}





