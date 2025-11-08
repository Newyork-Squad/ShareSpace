import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final SecureStorage _instance = SecureStorage._internal();
  factory SecureStorage() => _instance;
  SecureStorage._internal();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: "token", value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: "token");
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: "token");
  }
}