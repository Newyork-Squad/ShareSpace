abstract class AuthenticationRepository {
  Future<bool> login(String username, String password);

  Future<bool> createAccount({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required String gender,
    String? imageUrl,
    String? bio,
  });
}
