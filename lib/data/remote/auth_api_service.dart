import 'dart:io';

abstract class AuthApiService {
  Future<bool> login(String phoneNumber, String password);

  Future<bool> createAccount({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required String gender,
    File? imageFile,
    String? bio,
  });

  Future<void> logout();

  Future<bool> isLoggedIn();
}
