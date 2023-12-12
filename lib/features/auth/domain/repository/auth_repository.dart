abstract class AuthRepository {
  Future<String?> login(String email, String password);
  Future<bool> logout(String email, String password);
}
