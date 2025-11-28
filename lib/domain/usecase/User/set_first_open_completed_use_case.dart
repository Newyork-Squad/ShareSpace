
import '../../repository/app_preferences_repository.dart';

class SetFirstOpenCompletedUseCase {
  final AppPreferencesRepository _repository;

  SetFirstOpenCompletedUseCase(this._repository);

  Future<void> call() async {
    await _repository.setFirstOpenCompleted();
  }
}
