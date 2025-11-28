abstract class AppPreferencesRepository {
  Future<bool> isFirstOpen();

  Future<void> setFirstOpenCompleted();
}
