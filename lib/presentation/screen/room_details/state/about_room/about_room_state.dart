abstract class AboutRoomState {}

class AboutRoomInitial extends AboutRoomState {}

class AboutRoomLoading extends AboutRoomState {}

class AboutRoomLoaded extends AboutRoomState {
  final RoomDetailsData data;
  AboutRoomLoaded(this.data);
}

class AboutRoomError extends AboutRoomState {
  final String message;
  AboutRoomError(this.message);
}
// it will change after use api
class RoomDetailsData {
  final double overallRating;
  final int totalReviews;
  final Map<int, double> ratingDistribution;
  final List<ReviewModel> reviews;

  RoomDetailsData({
    required this.overallRating,
    required this.totalReviews,
    required this.ratingDistribution,
    required this.reviews,
  });
}

class ReviewModel {
  final String reviewerName;
  final String reviewerImage;
  final String reviewDate;
  final int rating;
  final String reviewText;

  ReviewModel({
    required this.reviewerName,
    required this.reviewerImage,
    required this.reviewDate,
    required this.rating,
    required this.reviewText,
  });
}
