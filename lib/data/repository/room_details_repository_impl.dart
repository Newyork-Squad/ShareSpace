import 'package:share_space/domain/entity/room_details.dart';
import 'package:share_space/domain/entity/workspace.dart';
import 'package:share_space/domain/repository/room_details_repository.dart';

import '../remote/dto/WorkspaceResponse.dart';
import '../remote/workspace_api_service.dart';

class RoomDetailsRepositoryImpl implements RoomDetailsRepository {
  final WorkspaceApiService _apiService;

  RoomDetailsRepositoryImpl(this._apiService);

  @override
  Future<RoomDetails> getRoomDetails(String id) async {
    try {
      final response = await _apiService.getById(id);
      return _mapToEntity(response);
    } catch (e) {
      throw Exception('Failed to fetch room details: $e');
    }
  }

  RoomDetails _mapToEntity(WorkspaceResponse dto) {
    return RoomDetails(
      id: int.tryParse(dto.id) ?? 0,
      name: dto.title,
      description: dto.description,
      locationName: dto.location,
      longitude: dto.longitude,
      latitude: dto.latitude,
      pricePerHour: dto.price,
      services: _mapAmenities(dto.amenities),
      imageUrls: dto.images ?? const [],
      rating: dto.rating,
      reviewsCount: dto.reviewsNo,
      capacity: dto.capacity,
      isAvailable: dto.availability,
      rules: dto.houseRules ?? '',
      owner: _mapOwner(dto.owner),
      reviews: _mapReviews(dto.reviews),
      ratingDistribution: dto.ratingDistribution,
    );
  }

  List<Services> _mapAmenities(List<String> amenities) {
    final List<Services> services = [];
    for (final amenity in amenities) {
      switch (amenity.toLowerCase()) {
        case 'wifi':
          services.add(Services.wifi);
          break;
        case 'ac':
        case 'air conditioning':
          services.add(Services.ac);
          break;
        case 'whiteboard':
          services.add(Services.whiteboard);
          break;
        case 'power backup':
        case 'powerbackup':
          services.add(Services.powerBackup);
          break;
      }
    }
    return services;
  }

  RoomOwner? _mapOwner(RoomOwnerResponse? owner) {
    if (owner == null || owner.id.isEmpty) {
      return null;
    }

    return RoomOwner(
      id: owner.id,
      name: owner.name,
      role: owner.role,
      avatarUrl: owner.avatarUrl,
    );
  }

  List<RoomReview> _mapReviews(List<RoomReviewResponse> reviews) {
    return reviews
        .map(
          (review) => RoomReview(
            id: review.id,
            reviewerName: review.reviewerName,
            reviewerImage: review.reviewerImage,
            comment: review.comment,
            rating: review.rating,
            createdAt: review.createdAt,
          ),
        )
        .toList();
  }
}

