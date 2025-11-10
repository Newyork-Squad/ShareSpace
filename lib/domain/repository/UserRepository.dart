import 'package:share_space/domain/entity/user.dart';

abstract class UserRepository{
  Future<User> getUserDetails();
}