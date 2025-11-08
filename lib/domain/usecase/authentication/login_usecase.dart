import '../../repository/authentication_repository.dart';

class LoginUseCase {
  final AuthenticationRepository _authenticationRepository;

  LoginUseCase(this._authenticationRepository);

  Future<bool> call(String phoneNumber, String password) {
    return _authenticationRepository.login(phoneNumber, password);
  }
}