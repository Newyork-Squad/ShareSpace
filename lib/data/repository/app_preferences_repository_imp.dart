import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repository/app_preferences_repository.dart';

class AppPreferencesRepositoryImpl implements AppPreferencesRepository {
  static const String _keyFirstOpen = 'isFirstOpen';
  final SharedPreferences _prefs;

  AppPreferencesRepositoryImpl(this._prefs);

  @override
  Future<bool> isFirstOpen() async {
    return _prefs.getBool(_keyFirstOpen) ?? true;
  }

  @override
  Future<void> setFirstOpenCompleted() async {
    await _prefs.setBool(_keyFirstOpen, false);
  }
}
