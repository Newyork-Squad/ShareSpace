import '../entity/search.dart';
import '../entity/workspace.dart';

abstract class SearchRepository {
  Future<List<Workspace>> searchWorkspaces({
    required SearchRequest request,
  });

  Future<List<String>> getSuggestions({required String keyword});
}
