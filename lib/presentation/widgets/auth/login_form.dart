// lib/presentation/widgets/auth/login_form.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'custom_textfield.dart';
import '../../../core/theme/app_theme.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with SingleTickerProviderStateMixin {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  bool obscurePassword = true;
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _goToDashboard() {
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primary, Color(0xFF3A466E)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
            child: Card(
              elevation: 12,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/LOGOOO.png',
                      height: 100,
                    ),
                    const SizedBox(height: 22),
                    Text(
                      "¡Bienvenido de Nuevo!",
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Nos alegra verte de vuelta.\nInicia sesión para continuar.",
                      style: GoogleFonts.openSans(
                        fontSize: 15,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    CustomTextField(
                      controller: emailController,
                      label: "Usuario",
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 18),
                    CustomTextField(
                      controller: passwordController,
                      label: "Contraseña",
                      icon: Icons.lock_outline,
                      obscureText: obscurePassword,
                      showVisibilityIcon: true,
                      onToggleVisibility: () {
                        setState(() => obscurePassword = !obscurePassword);
                      },
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          elevation: 6,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          shadowColor: AppTheme.primary.withOpacity(0.25),
                        ),
                        onPressed: _goToDashboard,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.login, color: Colors.white, size: 22),
                            const SizedBox(width: 10),
                            Text(
                              "Iniciar Sesión",
                              style: GoogleFonts.montserrat(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}