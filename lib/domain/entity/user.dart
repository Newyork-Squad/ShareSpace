
import 'dart:ffi';

class User {
  final int id;
  final String name;
  final Gender gender;
  final String email;
  final String phoneNumber;
  final String? profileImageUrl;
  final String? bio;

  User({
    required this.id,
    required this.name,
    required this.gender,
    required this.email,
    required this.phoneNumber,
    this.profileImageUrl,
    this.bio,
  });
}


enum Gender {
  male,
  female
}