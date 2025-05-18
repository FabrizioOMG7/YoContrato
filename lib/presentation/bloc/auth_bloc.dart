// lib/presentation/bloc/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/login_user.dart';


// Estados
abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {}
class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

// Eventos
abstract class AuthEvent {}
class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;
  LoginButtonPressed(this.email, this.password);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;

  AuthBloc(this.loginUser) : super(AuthInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

void _onLoginButtonPressed(LoginButtonPressed event, Emitter<AuthState> emit) async {
  emit(AuthLoading());
  await Future.delayed(const Duration(milliseconds: 500)); // Simula carga
  emit(AuthSuccess());
}
}