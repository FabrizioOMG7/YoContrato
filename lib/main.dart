// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Importaciones del módulo de Stats
import 'presentation/bloc/stat/stat_cubit.dart';
import 'data/datasources/stat_remote_datasource.dart';
import 'data/repositories/stat_repository_impl.dart';
import 'domain/usecases/get_stats.dart';

// Importaciones del módulo de Login
import 'presentation/bloc/auth/auth_bloc.dart'; // AuthBloc
import 'domain/usecases/login_user.dart'; // LoginUser
import 'data/repositories/auth_repository_impl.dart'; // AuthRepositoryImpl

import 'presentation/pages/dashboard_page.dart';
import 'presentation/pages/login_page.dart';
import 'core/theme/app_theme.dart';

void main() {
  // Configura dependencias para StatCubit (si es necesario)
  final statsRemote = StatRemoteDatasourceImpl();
  final statsRepository = StatRepositoryImpl(statsRemote);
  final getStats = GetStats(statsRepository);
  final statCubit = StatCubit(getStats);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => statCubit),
        BlocProvider(
          create: (context) => AuthBloc(
            LoginUser(AuthRepositoryImpl()), // Inicialización correcta
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yo Contrato',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}