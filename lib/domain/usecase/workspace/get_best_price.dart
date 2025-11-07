import '../../entity/workspace.dart';
import '../../repository/workspace_repository.dart';

class GetBestPriceUseCase {
  final WorkspaceRepository _repository;

  GetBestPriceUseCase(this._repository);

  Future<List<Workspace>> call() {
    return _repository.getBestPrice();
  }
}
