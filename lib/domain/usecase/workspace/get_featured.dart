import '../../entity/workspace.dart';
import '../../repository/workspace_repository.dart';

class GetFeaturedUseCase {
  final WorkspaceRepository _repository;

  GetFeaturedUseCase(this._repository);

  Future<List<Workspace>> call() {
    return _repository.getFeatured();
  }
}
