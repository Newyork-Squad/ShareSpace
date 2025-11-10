import 'dart:ui';


class UserResponse {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final ApiGender gender;
  final String? imageUrl;
  final String? bio;

  UserResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    this.imageUrl,
    this.bio,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      gender: ApiGender.fromString(json['gender'] as String?),
      imageUrl: json['imageUrl'] as String?,
      bio: json['bio'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender.name,
      'imageUrl': imageUrl,
      'bio': bio,
    };
  }
}
enum ApiGender {
  MALE,
  FEMALE,
  OTHER,
  PREFER_NOT_TO_SAY;

  static ApiGender fromString(String? value) {
    if (value == null) return ApiGender.OTHER;
    try {
      return ApiGender.values.firstWhere(
            (e) => e.name == value.toUpperCase(),
      );
    } catch (e) {
      return ApiGender.OTHER;
    }
  }
}
