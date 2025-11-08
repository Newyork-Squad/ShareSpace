import 'package:dio/dio.dart';

import 'dto/WorkspaceResponse.dart';
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
      );

      if (response.data['success'] == true) {
        final data = response.data['data']['content'];
        return WorkspaceResponse.listFromJson(data);
      } else {
        throw Exception(
          response.data['message'] ?? 'Failed to fetch workspaces',
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
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
      );

      if (response.data['success'] == true) {
        final data = response.data['data']['content'];
        return WorkspaceResponse.listFromJson(data);
      } else {
        throw Exception(
          response.data['message'] ?? 'Failed to fetch workspaces',
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
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
      );

      if (response.data['success'] == true) {
        final data = response.data['data']['content'];
        return WorkspaceResponse.listFromJson(data);
      } else {
        throw Exception(
          response.data['message'] ?? 'Failed to fetch workspaces',
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
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
      );

      if (response.data['success'] == true) {
        final data = response.data['data']['content'];
        return WorkspaceResponse.listFromJson(data);
      } else {
        throw Exception(
          response.data['message'] ?? 'Failed to fetch workspaces',
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<WorkspaceResponse> getById(String id) async {
    try {
      final response = await _dio.get('/workspace/$id');

      if (response.data['success'] == true) {
        final data = response.data['data'];
        return WorkspaceResponse.fromJson(data);
      } else {
        throw Exception(response.data['message'] ?? 'Workspace not found');
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.response != null) {
      final message = e.response?.data['message'] ?? 'Server error occurred';
      return Exception(message);
    } else if (e.type == DioExceptionType.connectionTimeout) {
      return Exception('Connection timeout');
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return Exception('Receive timeout');
    } else if (e.type == DioExceptionType.connectionError) {
      return Exception('No internet connection');
    } else {
      return Exception('Unexpected error occurred');
    }
  }
}
