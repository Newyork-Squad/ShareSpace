import 'package:share_space/domain/repository/workspace_repository.dart';

class SaveWorkspaceUseCase {
  final WorkspaceRepository _repository;

  SaveWorkspaceUseCase(this._repository);

  Future<void> call(String workspaceId) {
    return _repository.saveWorkspace(workspaceId);
  }
}