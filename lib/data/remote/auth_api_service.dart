import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_space/data/remote/api_constants.dart';
import 'package:share_space/data/util/secure_storage.dart';

import 'error_handler.dart';

class AuthApiService {
  final Dio _dio;
  AuthApiService(this._dio);

  Future<bool> login(String phoneNumber, String password) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: {
          'phoneNumber': phoneNumber,
          'password': password,
        },
      );

      if (response.data['success'] == true) {
        final token = response.data['data']['accessToken'];
        debugPrint("Login successful, token: $token");
        await SecureStorage().saveToken(token);
        return true;
      } else {
        throw Exception(
          response.data['message'] ?? 'Login failed',
        );
      }
    } on DioException catch (e) {
      throw handleError(e);
    }
  }

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
        throw Exception(
          response.data['message'] ?? 'Failed to create account',
        );
      }
    } on DioException catch (e) {
      throw handleError(e);
    }
  }
}