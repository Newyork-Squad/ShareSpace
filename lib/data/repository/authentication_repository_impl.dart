import 'package:share_space/domain/repository/authentication_repository.dart';

import '../remote/auth_api_service.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthApiService _apiService;

  AuthenticationRepositoryImpl(this._apiService);

  @override
  Future<bool> login(String phoneNumber, String password) {
    return _apiService.login(phoneNumber, password);
  }
}