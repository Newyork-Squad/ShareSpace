import '../../entity/workspace.dart';
import '../../repository/workspace_repository.dart';

class GetTopRatedUseCase {
  final WorkspaceRepository _repository;

  GetTopRatedUseCase(this._repository);

  Future<List<Workspace>> call() {
    return _repository.getTopRated();
  }
}
