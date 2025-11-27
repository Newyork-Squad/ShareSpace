

import 'dart:convert';

class WorkspaceResponse {
  final String id;
  final String title;
  final String description;
  final String location;
  final double latitude;
  final double longitude;
  final double price;
  final List<String> amenities;
  final List<String>? images;
  final double? rating;
  final int? reviewsNo;
  final int? capacity;
  final bool availability;
  final String? houseRules;
  final RoomOwnerResponse? owner;
  final List<RoomReviewResponse> reviews;
  final Map<int, double>? ratingDistribution;

  WorkspaceResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.price,
    required this.amenities,
    this.images,
    this.rating,
    this.reviewsNo,
    this.capacity,
    required this.availability,
    this.houseRules,
    this.owner,
    List<RoomReviewResponse>? reviews,
    this.ratingDistribution,
  }) : reviews = reviews ?? const [];

  factory WorkspaceResponse.fromJson(Map<String, dynamic> json) {
    final owner = RoomOwnerResponse.fromJson(json['owner']);
    final reviews = RoomReviewResponse.listFromJson(json['reviews']);
    final ratingDistribution = _parseRatingDistribution(json['ratingDistribution']);

    return WorkspaceResponse(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      amenities: List<String>.from(json['amenities'] ?? []),
      images: json['images'] != null
          ? (json['images'] is List
              ? List<String>.from(json['images'])
              : (json['images'] as String).split(','))
          : null,
      rating:
          (json['rating'] != null) ? (json['rating'] as num).toDouble() : null,
      reviewsNo: json['reviewsNo'],
      capacity: json['capacity'],
      availability: json['availability'] ?? false,
      houseRules: json['houseRules'],
      owner: owner,
      reviews: reviews,
      ratingDistribution: ratingDistribution,
    );
  }

  static List<WorkspaceResponse> listFromJson(dynamic data) {
    if (data is List) {
      return data.map((e) => WorkspaceResponse.fromJson(e)).toList();
    } else if (data is String) {
      return (jsonDecode(data) as List)
          .map((e) => WorkspaceResponse.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }

  static Map<int, double>? _parseRatingDistribution(dynamic data) {
    if (data is Map) {
      final Map<int, double> distribution = {};
      data.forEach((key, value) {
        final parsedKey = int.tryParse(key.toString());
        if (parsedKey != null && value is num) {
          distribution[parsedKey] = value.toDouble();
        }
      });
      return distribution.isEmpty ? null : distribution;
    }
    return null;
  }
}

class RoomOwnerResponse {
  final String id;
  final String? name;
  final String? role;
  final String? avatarUrl;

  RoomOwnerResponse({
    required this.id,
    this.name,
    this.role,
    this.avatarUrl,
  });

  static RoomOwnerResponse? fromJson(dynamic json) {
    if (json == null) return null;

    if (json is String && json.isNotEmpty) {
      return RoomOwnerResponse(id: json);
    }

    if (json is Map<String, dynamic>) {
      final dynamic idValue = json['id'] ?? json['ownerId'] ?? json['userId'];
      if (idValue == null) return null;

      return RoomOwnerResponse(
        id: idValue.toString(),
        name: json['name'] ?? json['fullName'] ?? json['username'],
        role: json['role'] ?? json['userRole'],
        avatarUrl: json['avatar'] ??
            json['avatarUrl'] ??
            json['profileImage'] ??
            json['profileImageUrl'],
      );
    }

    return null;
  }
}

class RoomReviewResponse {
  final String? id;
  final String? reviewerName;
  final String? reviewerImage;
  final String? comment;
  final double? rating;
  final DateTime? createdAt;

  RoomReviewResponse({
    this.id,
    this.reviewerName,
    this.reviewerImage,
    this.comment,
    this.rating,
    this.createdAt,
  });

  factory RoomReviewResponse.fromJson(Map<String, dynamic> json) {
    final ratingValue = json['rating'] ?? json['rate'] ?? json['score'];
    final createdAtValue = json['createdAt'] ?? json['date'] ?? json['timestamp'];
    DateTime? createdAt;

    if (createdAtValue is String) {
      createdAt = DateTime.tryParse(createdAtValue);
    } else if (createdAtValue is int) {
      createdAt =
          DateTime.fromMillisecondsSinceEpoch(createdAtValue, isUtc: true);
    }

    String? reviewerImage;
    final reviewer = json['reviewer'] ?? json['user'] ?? json['author'];
    if (reviewer is Map<String, dynamic>) {
      reviewerImage = reviewer['avatar'] ??
          reviewer['avatarUrl'] ??
          reviewer['profileImage'] ??
          reviewer['profileImageUrl'];
    }

    return RoomReviewResponse(
      id: json['id']?.toString(),
      reviewerName: json['reviewerName'] ??
          reviewer?['name'] ??
          reviewer?['fullName'] ??
          json['userName'],
      reviewerImage:
          json['reviewerImage'] ?? reviewerImage ?? json['userAvatar'],
      comment: json['comment'] ?? json['reviewText'] ?? json['text'],
      rating: ratingValue is num ? ratingValue.toDouble() : null,
      createdAt: createdAt,
    );
  }

  factory RoomReviewResponse.fromComment(String comment) {
    return RoomReviewResponse(comment: comment);
  }

  static List<RoomReviewResponse> listFromJson(dynamic data) {
    if (data is List) {
      return data
          .map((item) {
            if (item is Map<String, dynamic>) {
              return RoomReviewResponse.fromJson(item);
            } else if (item is String) {
              return RoomReviewResponse.fromComment(item);
            }
            return null;
          })
          .whereType<RoomReviewResponse>()
          .toList();
    }
    return const [];
  }
}