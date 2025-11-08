abstract class AuthenticationRepository {
  Future<bool> login(String username, String password);
}
