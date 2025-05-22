import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/stat/stat_cubit.dart';
import '../widgets/stat_card.dart';
import '../../core/theme/app_theme.dart';
import 'register_applicant_page.dart';
import '../../shared/app_footer.dart';
import '../../shared/modules_panel.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 2;
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  bool isDarkMode = false;
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

  void _showModulesMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ModulesPanel(
        isDarkMode: isDarkMode,
        onModuleTap: (index) {
          // Acción al seleccionar módulo (opcional)
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _showSettingsModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildSettingsPanel(),
    );
  }

Widget _buildHeader() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 20),
   // ...en _buildHeader()
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            isDarkMode ? const Color(0xFF030F0F) : AppTheme.primary,
        title: Text(
          'YO CONTRATO',
          style: GoogleFonts.merriweather(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 1.3,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: _showSettingsModal,
          ),
        ],
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
      bottomNavigationBar: AppFooter(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            _showModulesMenu();
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RegisterApplicantPage()),
            );
          } else {
            setState(() => _currentIndex = index);
          }
        },
      ),
    );
  }

  // Panel de configuración
  Widget _buildSettingsPanel() {
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final iconColor = isDarkMode ? Colors.white : AppTheme.primary;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF030F0F) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 18),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: iconColor),
              title: Text(
                "Cambiar sede",
                style: GoogleFonts.montserrat(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: DropdownButton<String>(
                dropdownColor:
                    isDarkMode ? const Color(0xFF161F49) : Colors.white,
                value: sede,
                underline: const SizedBox(),
                style: GoogleFonts.montserrat(color: textColor),
                items: const [
                  DropdownMenuItem(value: "Chiclayo", child: Text("Chiclayo")),
                  DropdownMenuItem(value: "Lima", child: Text("Lima")),
                  DropdownMenuItem(value: "Arequipa", child: Text("Arequipa")),
                  DropdownMenuItem(value: "Trujillo", child: Text("Trujillo")),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      sede = value;
                    });
                    Navigator.pop(context);
                  }
                },
              ),
            ),
            Divider(color: isDarkMode ? Colors.white24 : Colors.grey[300]),
            SwitchListTile(
              secondary: Icon(
                isDarkMode ? Icons.nightlight_round : Icons.wb_sunny_outlined,
                color: iconColor,
              ),
              title: Text(
                "Tema",
                style: GoogleFonts.montserrat(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
                Navigator.pop(context);
              },
              activeColor: Colors.white,
            ),
            Divider(color: isDarkMode ? Colors.white24 : Colors.grey[300]),
            ListTile(
              leading: Icon(Icons.logout, color: iconColor),
              title: Text(
                "Salir",
                style: GoogleFonts.montserrat(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}