abstract class AuthenticationRepository {
  Future<bool> login(String phoneNumber, String password);

  Future<bool> createAccount({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required String gender,
    String? imageUrl,
    String? bio,
  });

  Future<bool> isLoggedIn();

  Future<void> logout();
}
