import 'dto/WorkspaceResponse.dart';
import 'dto/WorkspaceSearchRequestDto.dart';

abstract class SearchApiService {
  Future<List<WorkspaceResponse>> searchWorkspaces({
    required WorkspaceSearchRequestDto request,
    int page = 0,
    int size = 10,
  });

  Future<List<String>> getSuggestions({
    required String keyword,
  });
}
