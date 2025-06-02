import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/app_settings_button.dart';
import 'package:yo_contrato_app/presentation/widgets/shared/app_topbar.dart';
import '../bloc/stat/stat_cubit.dart';
import '../widgets/stat_card.dart';
import '../../core/theme/app_theme.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  bool isDarkMode = false; //Esto lo manejaré luego manualmente, por ahora es un ejemplo
  String sede = "Chiclayo";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 20),
      decoration: BoxDecoration(
        gradient: isDarkMode
            ? null
            : const LinearGradient(
                colors: [Color(0xFFE5E8EF), Color(0xFFF7F8FA)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
        color: isDarkMode ? const Color(0xFF23263A) : null,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sede,
                  style: GoogleFonts.openSans(
                    color: isDarkMode ? Colors.white54 : Colors.black45,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '¡Bienvenido!',
                  style: GoogleFonts.montserrat(
                    color: isDarkMode ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(
                  'YO CONTRATO',
                  style: GoogleFonts.montserrat(
                    color: isDarkMode ? Colors.white38 : Colors.black38,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.notifications_none,
            color: isDarkMode ? Colors.white : Colors.black54,
            size: 30,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(StatState state) {
    if (state is StatsLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is StatsLoaded) {
      return FadeTransition(
        opacity: _fadeAnimation,
        child: GridView.builder(
          itemCount: state.stats.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.05,
          ),
          itemBuilder: (_, i) =>
              StatCard(stat: state.stats[i], isDark: isDarkMode),
        ),
      );
    }
    return const Center(child: Text('Error cargando datos'));
  }

  @override
  Widget build(BuildContext context) {
    context.read<StatCubit>().loadStats();
    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xFF030F0F) : const Color(0xFFF5F6FA),
      appBar: AppTopBar(
        title: 'YO CONTRATO',
        actions:[
          SettingsButton(
            isDarkMode: isDarkMode,
            sede: sede, 
            onSedeChanged: (newSede){
              setState(() {
                sede = newSede;
              });
            },
              onLogout: () {  
                Navigator.pushReplacementNamed(context, '/login');
              },
          )
        ],
       // backgroundColor: AppTheme.primary, // O tu color dinámico
        //textColor: Colors.white,
      ),
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  'Postulantes',
                  style: GoogleFonts.montserrat(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : AppTheme.primary,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.people,
                  color: isDarkMode ? Colors.white : AppTheme.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<StatCubit, StatState>(
                builder: (ctx, state) => _buildStatsGrid(state),
              ),
            ),
          ),
        ],
      ),
    );
  }

    }