import '../../repository/authentication_repository.dart';

class LoginUseCase {
  final AuthenticationRepository _authenticationRepository;

  LoginUseCase(this._authenticationRepository);

  Future<bool> execute(String username, String password) {
    return _authenticationRepository.login(username, password);
  }
}