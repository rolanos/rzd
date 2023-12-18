import 'package:rzd/features/auth/domain/entity/user_model.dart';

abstract class AuthRepository {
  Future<UserProfile?> login(String email, String password);
  Future<bool> logout(String email, String password);
}
