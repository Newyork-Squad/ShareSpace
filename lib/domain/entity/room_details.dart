import 'workspace.dart';

class RoomDetails {
  final int id;
  final String name;
  final String description;
  final String locationName;
  final double longitude;
  final double latitude;
  final double pricePerHour;
  final double? rating;
  final int? reviewsCount;
  final bool isAvailable;
  final int? capacity;
  final String rules;
  final List<Services> services;
  final List<String> imageUrls;
  final RoomOwner? owner;
  final List<RoomReview> reviews;
  final Map<int, double>? ratingDistribution;

  RoomDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.locationName,
    required this.longitude,
    required this.latitude,
    required this.pricePerHour,
    required this.services,
    required this.imageUrls,
    required this.isAvailable,
    this.rating,
    this.reviewsCount,
    this.capacity,
    this.rules = '',
    this.owner,
    List<RoomReview>? reviews,
    this.ratingDistribution,
  }) : reviews = reviews ?? const [];
}

class RoomOwner {
  final String id;
  final String? name;
  final String? role;
  final String? avatarUrl;

  const RoomOwner({
    required this.id,
    this.name,
    this.role,
    this.avatarUrl,
  });
}

class RoomReview {
  final String? id;
  final String? reviewerName;
  final String? reviewerImage;
  final String? comment;
  final double? rating;
  final DateTime? createdAt;

  const RoomReview({
    this.id,
    this.reviewerName,
    this.reviewerImage,
    this.comment,
    this.rating,
    this.createdAt,
  });
}

