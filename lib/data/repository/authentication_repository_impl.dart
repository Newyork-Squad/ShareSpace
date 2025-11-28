import 'dart:io';
import 'package:share_space/domain/repository/authentication_repository.dart';

import '../remote/auth_api_service.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthApiService _apiService;

  AuthenticationRepositoryImpl(this._apiService);

  @override
  Future<bool> login(String phoneNumber, String password) {
    return _apiService.login(phoneNumber, password);
  }

  @override
  Future<bool> createAccount({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required String gender,
    File? imageFile,
    String? bio,
  }) {
    return _apiService.createAccount(
      email: email,
      password: password,
      name: name,
      phoneNumber: phoneNumber,
      gender: gender,
      imageFile: imageFile,
      bio: bio,
    );
  }

  @override
  Future<bool> isLoggedIn() {
    return _apiService.isLoggedIn();
  }

  @override
  Future<void> logout() {
    return _apiService.logout();
  }
}
