import '../../entity/workspace.dart';
import '../../repository/workspace_repository.dart';

class GetBestUseCase {
  final WorkspaceRepository _repository;

  GetBestUseCase(this._repository);

  Future<List<Workspace>> call() {
    return _repository.getBest();
  }
}
