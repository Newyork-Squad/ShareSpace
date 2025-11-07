import '../../entity/workspace.dart';
import '../../repository/workspace_repository.dart';

class GetNearToYouUseCase {
  final WorkspaceRepository _repository;

  GetNearToYouUseCase(this._repository);

  Future<List<Workspace>> call({
    required double latitude,
    required double longitude,
  }) {
    return _repository.getNearToYou(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
