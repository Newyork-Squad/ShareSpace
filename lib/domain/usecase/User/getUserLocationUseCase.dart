import 'package:share_space/domain/repository/UserRepository.dart';

class GetCurrentLocationUseCase {
  final UserRepository _repository;
  GetCurrentLocationUseCase(this._repository);

  Future<String> call() {
    return _repository.getUserCurrentLocation();
  }
}