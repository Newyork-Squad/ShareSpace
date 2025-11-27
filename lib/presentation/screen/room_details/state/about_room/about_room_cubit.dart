import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/presentation/screen/room_details/state/about_room/about_room_state.dart';

class AboutRoomCubit extends Cubit<AboutRoomState> {
  AboutRoomCubit() : super(AboutRoomInitial());

  Future<void> loadRoomDetails() async {
    emit(AboutRoomLoading());

    try {
      // fake data for now
      final reviews = [
        ReviewModel(
          reviewerName: 'Hamsa Ali Hussain',
          reviewerImage: 'assets/images/owner.png',
          reviewDate: '12-04-2024',
          rating: 5,
          reviewText:
              'Cozy and quiet workspace! The WiFi was fast, and the chairs were super comfy. Perfect for long study sessions.',
        ),
        ReviewModel(
          reviewerName: 'Ali Kareem',
          reviewerImage: 'assets/images/owner.png',
          reviewDate: '12-04-2024',
          rating: 4,
          reviewText:
              'The room was nice but a bit noisy in the afternoon. Still great value for money!',
        ),
        ReviewModel(
          reviewerName: 'Sara Mahmood',
          reviewerImage: 'assets/images/owner.png',
          reviewDate: '12-04-2024',
          rating: 5,
          reviewText:
              'Clean and bright place. Staff was friendly, and booking was super easy through the app.',
        ),
        ReviewModel(
          reviewerName: 'Fatima Hassan',
          reviewerImage: 'assets/images/owner.png',
          reviewDate: '12-04-2024',
          rating: 4,
          reviewText:
              'Could use better lighting at night. Everything else was great.',
        ),
        ReviewModel(
          reviewerName: 'Mohammed Yousif',
          reviewerImage: 'assets/images/owner.png',
          reviewDate: '12-04-2024',
          rating: 5,
          reviewText:
              'Spacious and well-maintained. I loved the complimentary coffee corner.',
        ),
      ];

      final fakeData = RoomDetailsData(
        overallRating: 4.0,
        totalReviews: reviews.length,
        ratingDistribution: {
          5: 0.8,
          4: 0.6,
          3: 0.4,
          2: 0.2,
          1: 0.1,
        },
        reviews: reviews,
      );

      emit(AboutRoomLoaded(fakeData));
    } catch (e) {
      emit(AboutRoomError('Failed to load room details'));
    }
  }
}





