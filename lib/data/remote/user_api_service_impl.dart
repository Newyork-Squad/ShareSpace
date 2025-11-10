import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_space/data/remote/api_constants.dart';
import 'package:share_space/data/remote/dto/UserResponse.dart';
import 'package:share_space/data/remote/user_api_service.dart';

import 'error_handler.dart';

class UserApiServiceImpl implements UserApiService{
  final Dio _dio;
  UserApiServiceImpl(this._dio);
  @override
  Future<UserResponse> getCurrentUser() async {
    try {
      final response = await _dio.get(ApiConstants.userDetails);

      if (response.data['success'] == true && response.data['data'] != null) {

        return UserResponse.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to get user profile');
      }
    } on DioException catch (e) {
      throw handleError(e);
    } catch (e) {
      debugPrint("Error getting current user: $e");
      rethrow;
    }
  }
}

