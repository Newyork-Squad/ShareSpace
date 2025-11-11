import 'package:share_space/domain/entity/user.dart';

import '../../repository/UserRepository.dart';

class GetUserDetailsUseCase{
  final UserRepository _repository;

  GetUserDetailsUseCase(this._repository);

  Future<User> call(){
    return _repository.getUserDetails();
  }

}