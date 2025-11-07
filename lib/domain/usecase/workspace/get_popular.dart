import '../../entity/workspace.dart';
import '../../repository/workspace_repository.dart';

class GetPopularUseCase {
  final WorkspaceRepository _repository;

  GetPopularUseCase(this._repository);

  Future<List<Workspace>> call() {
    return _repository.getPopular();
  }
}
