// lib/core/errors/auth_errors.dart
class InvalidEmailException implements Exception {
  final String message = "Correo electrónico inválido";
}

class WeakPasswordException implements Exception {
  final String message = "La contraseña debe tener al menos 6 caracteres";
}