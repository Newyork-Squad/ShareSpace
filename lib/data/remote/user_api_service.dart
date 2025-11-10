
import 'package:share_space/data/remote/dto/UserResponse.dart';

abstract class UserApiService{
Future<UserResponse> getCurrentUser();
}