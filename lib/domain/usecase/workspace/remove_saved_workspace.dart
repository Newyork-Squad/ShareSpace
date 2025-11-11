import 'package:share_space/domain/repository/workspace_repository.dart';

class RemoveSavedWorkspaceUseCase {
  final WorkspaceRepository _repository;

  RemoveSavedWorkspaceUseCase(this._repository);

  Future<void> call(String workspaceId) {
    return _repository.removeSavedWorkspace(workspaceId);
  }
}