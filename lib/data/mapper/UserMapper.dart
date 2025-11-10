import '../../domain/entity/user.dart';
import '../remote/dto/UserResponse.dart';

extension UserResponseMapper on UserResponse {
  User toEntity() {
    return User(
      id: int.tryParse(id) ?? 0,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      profileImageUrl: imageUrl,
      bio: bio,
      gender: _mapApiGenderToDomain(gender),
    );
  }

  Gender _mapApiGenderToDomain(ApiGender apiGender) {
    switch (apiGender) {
      case ApiGender.MALE:
        return Gender.male;
      case ApiGender.FEMALE:
        return Gender.female;
      default:
        return Gender.male; // Default fallback
    }
  }
}

extension UserMapper on User {
  UserResponse toResponse() {
    return UserResponse(
      id: id.toString(),
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      imageUrl: profileImageUrl,
      bio: bio,
      gender: _mapDomainGenderToApi(gender),
    );
  }

  ApiGender _mapDomainGenderToApi(Gender gender) {
    switch (gender) {
      case Gender.male:
        return ApiGender.MALE;
      case Gender.female:
        return ApiGender.FEMALE;
    }
  }
}
