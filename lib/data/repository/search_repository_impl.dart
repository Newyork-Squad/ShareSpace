import 'package:share_space/data/mapper/workspace_mapper.dart';

import '../../domain/entity/search.dart';
import '../../domain/entity/workspace.dart';
import '../../domain/repository/search_repository.dart';
import '../remote/dto/WorkspaceSearchRequestDto.dart';
import '../remote/search_api_service.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchApiService _apiService;

  SearchRepositoryImpl(this._apiService);

  @override
  Future<List<Workspace>> searchWorkspaces({
    required SearchRequest request,
  }) async {
    try {
      final dtoRequest = WorkspaceSearchRequestDto(
        keyword: request.keyword,
        minPrice: request.minPrice,
        maxPrice: request.maxPrice,
        minRating: request.rating,
        services: request.services,
        latitude: request.latitude,
        longitude: request.longitude,
        location: request.location,
      );

      final response = await _apiService.searchWorkspaces(request: dtoRequest);

      return response.map((dto) => dto.mapToEntity()).toList();
    } catch (e) {
      throw Exception('Failed to search workspaces: $e');
    }
  }

  @override
  Future<List<String>> getSuggestions({required String keyword}) async {
    try {
      return await _apiService.getSuggestions(keyword: keyword);
    } catch (e) {
      throw Exception('Failed to fetch suggestions: $e');
    }
  }
}
