import 'package:dio/dio.dart';
import 'package:share_space/data/remote/search_api_service.dart';

import 'dto/WorkspaceResponse.dart';
import 'dto/WorkspaceSearchRequestDto.dart';
import 'error_handler.dart';

class SearchApiServiceImpl extends SearchApiService {
  final Dio _dio;

  SearchApiServiceImpl(this._dio);

  @override
  Future<List<WorkspaceResponse>> searchWorkspaces({
    required WorkspaceSearchRequestDto request,
    int page = 0,
    int size = 10,
  }) async {
    try {
      final response = await _dio.post(
        '/workspace/search',
        data: request.toJson(),
        queryParameters: {'page': page, 'size': size},
      );

      final data = response.data;
      if (data == null) {
        throw Exception('No response data');
      }

      if (data['success'] != true) {
        throw Exception(data['message'] ?? 'Failed to fetch search results');
      }

      final content = data['data']?['content'];
      if (content is List) {
        return WorkspaceResponse.listFromJson(content);
      }

      return [];
    } on DioException catch (e) {
      throw handleError(e);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<List<String>> getSuggestions({required String keyword}) async {
    try {
      final response = await _dio.get(
        '/workspace/suggestions',
        queryParameters: {'keyword': keyword},
        options: Options(extra: {'forceRefresh': true}),
      );

      final data = response.data;
      if (data == null) {
        throw Exception('No response data');
      }

      if (data['success'] != true) {
        throw Exception(data['message'] ?? 'Failed to fetch suggestions');
      }

      final list = data['data'];
      if (list is List) {
        return List<String>.from(list);
      }

      return [];
    } on DioException catch (e) {
      throw handleError(e);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
