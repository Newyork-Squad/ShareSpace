import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_space/data/remote/api_constants.dart';

import '../local/token_storage.dart';
import 'auth_api_service.dart';
import 'error_handler.dart';

class AuthApiServiceImpl implements AuthApiService {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  AuthApiServiceImpl(this._dio, this._tokenStorage);

  @override
  Future<bool> login(String phoneNumber, String password) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: {'phoneNumber': phoneNumber, 'password': password},
      );

      if (response.data['success'] == true) {
        final accessToken = response.data['data']['accessToken'];
        final refreshToken = response.data['data']['refreshToken'];

        debugPrint("Login successful");

        await _tokenStorage.saveTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );

        return true;
      } else {
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      throw handleError(e);
    }
  }

  @override
  Future<bool> createAccount({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required String gender,
    String? imageUrl,
    String? bio,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.signup,
        data: {
          'email': email,
          'password': password,
          'name': name,
          'phoneNumber': phoneNumber,
          'gender': gender,
          'imageUrl': imageUrl ?? '',
          'bio': bio ?? '',
        },
      );

      if (response.data['success'] == true) {
        debugPrint("Create account successful: ${response.data['message']}");
        return true;
      } else {
        throw Exception(response.data['message'] ?? 'Failed to create account');
      }
    } on DioException catch (e) {
      throw handleError(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _tokenStorage.deleteTokens();
      debugPrint("Logout successful");
    } catch (e) {
      debugPrint("Error during logout: $e");
      rethrow;
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return await _tokenStorage.hasValidTokens();
  }
}
