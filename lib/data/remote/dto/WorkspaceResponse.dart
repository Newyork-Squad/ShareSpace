

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
  });

  factory WorkspaceResponse.fromJson(Map<String, dynamic> json) {
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
      rating: (json['rating'] != null) ? (json['rating'] as num).toDouble() : null,
      reviewsNo: json['reviewsNo'],
      capacity: json['capacity'],
      availability: json['availability'] ?? false,
      houseRules: json['houseRules'],
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
}