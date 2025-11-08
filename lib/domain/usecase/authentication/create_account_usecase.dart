import 'package:share_space/domain/repository/authentication_repository.dart';

class CreateAccountUseCase {
  final AuthenticationRepository _repository;

  CreateAccountUseCase(this._repository);

  Future<void> execute({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required String gender,
    String? imageUrl,
    String? bio,
  }) async {
    final success = await _repository.createAccount(
      email: email,
      password: password,
      name: name,
      phoneNumber: phoneNumber,
      gender: gender,
      imageUrl: imageUrl,
      bio: bio,
    );

    if (!success) {
      throw Exception('Failed to create account');
    }
  }
}
