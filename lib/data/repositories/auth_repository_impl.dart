import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';
import '../../core/errors/auth_errors.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User> login(String email, String password) async {
    // Simulación de autenticación
    await Future.delayed(const Duration(seconds: 1));

    if (!email.contains('@')) {
      throw InvalidEmailException();
    }
    if (password.length < 6) {
      throw WeakPasswordException();
    }

    // Usuario autenticado correctamente
    return User(email: email);
  }
}