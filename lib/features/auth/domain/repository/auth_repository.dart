import 'package:rzd/features/auth/domain/entity/user_model.dart';

abstract class AuthRepository {
  Future<UserProfile?> login(String email, String password);
  Future<bool> logout(String email, String password);

  Future<void> checkStatus(String fam, String name, String otch,
      DateTime birthday, String passSeries, String passNumber);
  Future<void> register(
      String login, String password, String rePassword, String uuid);
  Future<void> sentOtp(String uuid, String phone);
  Future<bool?> checkOtp(String uuid, String otp);
}
