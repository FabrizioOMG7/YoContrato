// lib/domain/value_objects/auth_vo.dart
import '../../core/errors/auth_errors.dart';

class Email {
  final String value;
  Email(this.value) {
    if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value)) {
      throw InvalidEmailException();
    }
  }
}

class Password {
  final String value;
  Password(this.value) {
    if (value.length < 6) throw WeakPasswordException();
  }
}