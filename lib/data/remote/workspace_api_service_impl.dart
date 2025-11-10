import 'package:dio/dio.dart';

import 'dio_client.dart';
import 'dto/WorkspaceResponse.dart';
import 'error_handler.dart';
import 'workspace_api_service.dart';

class WorkspaceApiServiceImpl implements WorkspaceApiService {
  final Dio _dio;

  WorkspaceApiServiceImpl(this._dio);

  @override
  Future<List<WorkspaceResponse>> getAll({
    int page = 0,
    int size = 10,
    String sortBy = 'createdAt',
    String direction = 'desc',
  }) async {
    try {
      final response = await _dio.get(
        '/workspace/all',
        queryParameters: {
          'page': page,
          'size': size,
          'sortBy': sortBy,
          'direction': direction,
        },
        options: DioClient.cacheOptions.toOptions(),
      );

      if (response.data['success'] == true) {
        return WorkspaceResponse.listFromJson(response.data['data']['content']);
      }
      throw Exception(response.data['message'] ?? 'Failed to fetch workspaces');
    } on DioException catch (e) {
      throw handleError(e);
    }
  }

  @override
  Future<List<WorkspaceResponse>> getByCategory(
    String category, {
    int page = 0,
    int size = 10,
  }) async {
    try {
      final response = await _dio.get(
        '/workspace/category',
        queryParameters: {'category': category, 'page': page, 'size': size},
        options: DioClient.cacheOptions.toOptions(),
      );

      if (response.data['success'] == true) {
        return WorkspaceResponse.listFromJson(response.data['data']['content']);
      }
      throw Exception(response.data['message'] ?? 'Failed to fetch workspaces');
    } on DioException catch (e) {
      throw handleError(e);
    }
  }

  @override
  Future<List<WorkspaceResponse>> getNearToYou({
    required double latitude,
    required double longitude,
    int page = 0,
    int size = 10,
  }) async {
    try {
      final response = await _dio.get(
        '/workspace/near',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'page': page,
          'size': size,
        },
        options: DioClient.cacheOptions.toOptions(),
      );

      if (response.data['success'] == true) {
        return WorkspaceResponse.listFromJson(response.data['data']['content']);
      }
      throw Exception(response.data['message'] ?? 'Failed to fetch workspaces');
    } on DioException catch (e) {
      throw handleError(e);
    }
  }

  @override
  Future<List<WorkspaceResponse>> getFeatured({
    int page = 0,
    int size = 10,
  }) async {
    try {
      final response = await _dio.get(
        '/workspace/featured',
        queryParameters: {'page': page, 'size': size},
        options: DioClient.cacheOptions.toOptions(),
      );

      if (response.data['success'] == true) {
        return WorkspaceResponse.listFromJson(response.data['data']['content']);
      }
      throw Exception(response.data['message'] ?? 'Failed to fetch workspaces');
    } on DioException catch (e) {
      throw handleError(e);
    }
  }

  @override
  Future<WorkspaceResponse> getById(String id) async {
    try {
      final response = await _dio.get(
        '/workspace/$id',
        options: DioClient.cacheOptions.toOptions(),
      );

      if (response.data['success'] == true) {
        return WorkspaceResponse.fromJson(response.data['data']);
      }
      throw Exception(response.data['message'] ?? 'Workspace not found');
    } on DioException catch (e) {
      throw handleError(e);
    }
  }
}
