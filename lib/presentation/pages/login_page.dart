// lib/presentation/pages/login_page.dart
import 'package:flutter/material.dart';
import '../widgets/auth/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginForm(),
    );
  }
}