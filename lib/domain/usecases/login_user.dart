// lib/domain/usecases/login_user.dart
import '../repositories/auth_repository.dart'; // Ruta correcta
import '../entities/user.dart'; // User importado

class LoginUser {
  final AuthRepository repository; 

  const LoginUser(this.repository);

  Future<User> call(String email, String password) {
    return repository.login(email, password);
  }
}