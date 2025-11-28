

import '../../repository/app_preferences_repository.dart';

class IsFirstOpenUseCase {
  final AppPreferencesRepository _repository;

  IsFirstOpenUseCase(this._repository);

  Future<bool> call() async {
    return await _repository.isFirstOpen();
  }
}
