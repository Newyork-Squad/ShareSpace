import '../../repository/authentication_repository.dart';

class IsLoggedInUseCase {
  final AuthenticationRepository _repository;

  IsLoggedInUseCase(this._repository);

  Future<bool> call() {
    return _repository.isLoggedIn();
  }
}
