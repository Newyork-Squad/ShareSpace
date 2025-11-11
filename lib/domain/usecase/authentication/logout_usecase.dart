import '../../repository/authentication_repository.dart';

class LogoutUseCase {
  final AuthenticationRepository _authRepository;

  LogoutUseCase(this._authRepository);

  Future<void> call() async {
    await _authRepository.logout();
  }
}
