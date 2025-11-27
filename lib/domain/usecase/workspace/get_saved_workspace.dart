import 'package:share_space/domain/entity/workspace.dart';
import 'package:share_space/domain/repository/workspace_repository.dart';

class GetSavedWorkspacesUseCase {
  final WorkspaceRepository _repository;

  GetSavedWorkspacesUseCase(this._repository);

  Future<List<Workspace>> call() {
    return _repository.getSavedWorkspaces();
  }
}