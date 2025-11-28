import '../../entity/search.dart';
import '../../entity/workspace.dart';
import '../../repository/search_repository.dart';

class SearchWorkspacesUseCase {
  final SearchRepository _repository;

  SearchWorkspacesUseCase(this._repository);

  Future<List<Workspace>> execute(SearchRequest request) async {
    return await _repository.searchWorkspaces(request: request);
  }
}
