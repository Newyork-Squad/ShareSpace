abstract class AuthenticationRepository {
  Future<bool> login(String phoneNumber, String password);
}
