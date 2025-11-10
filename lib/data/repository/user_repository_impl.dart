import 'package:share_space/data/mapper/UserMapper.dart';
import 'package:share_space/domain/entity/user.dart';
import 'package:share_space/domain/repository/UserRepository.dart';

import '../remote/user_api_service.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApiService _apiService;
  UserRepositoryImpl(this._apiService);

  @override
  Future<User> getUserDetails() async {
    try {
      final userResponse = await _apiService.getCurrentUser();
      return userResponse.toEntity();
    } catch (e) {
      print("Error fetching user details in repository: $e");
      rethrow;
    }
  }
}