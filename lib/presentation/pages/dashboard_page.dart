import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/stat_cubit.dart';
import '../../domain/entities/module.dart';
import '../widgets/stat_card.dart';
import '../../core/theme/app_theme.dart';
import 'register_applicant_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
  int _currentIndex = 2;
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  bool isDarkMode = false;
  String sede = "Chiclayo";

  final List<Module> _modules = [
    Module(name: 'Gestión de Postulaciones', completed: false),
    Module(name: 'Reclutamiento', completed: false),
    Module(name: 'Ficha Médica', completed: false),
    Module(name: 'BBS', completed: false),
    Module(name: 'Fotografía', completed: false),
    Module(name: 'Gestión de Contratos', completed: false),
    Module(name: 'Firma de Documentos', completed: false),
    Module(name: 'Validación y Fotocheck', completed: false),
    Module(name: 'Desistimiento', completed: false),
  ];
  final Map<String, IconData> moduleIcons = {
    'Gestión de Postulaciones': Icons.event,
    'Reclutamiento': Icons.person_search,
    'Ficha Médica': Icons.topic,
    'BBS': Icons.analytics,
    'Fotografía': Icons.camera_alt,
    'Gestión de Contratos': Icons.assignment,
    'Firma de Documentos': Icons.edit_document,
    'Validación y Fotocheck': Icons.badge,
    'Módulo Desistimiento': Icons.cancel,
  };

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
      builder: (context) => _buildModulesPanel(),
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
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(0xFF161F49)
            : null,
        gradient: isDarkMode
            ? null
            : LinearGradient(
                colors: [AppTheme.primary, AppTheme.primary.withOpacity(0.85)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
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
                    color: Colors.white70,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '¡Bienvenido!',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'YO CONTRATO',
                  style: GoogleFonts.montserrat(
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.notifications_none, color: Colors.white, size: 30),
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
          itemBuilder: (_, i) => StatCard(
            stat: state.stats[i],
            isDark: isDarkMode,
          ),
        ),
      );
    }
    return const Center(child: Text('Error cargando datos'));
  }

  @override
  Widget build(BuildContext context) {
    context.read<StatCubit>().loadStats();
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF030F0F) : const Color(0xFFF5F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDarkMode ? const Color(0xFF030F0F) : AppTheme.primary,
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
                Icon(Icons.people, color: isDarkMode ? Colors.white : AppTheme.primary),
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.18),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 6, top: 2),
          child: BottomNavigationBar(
            backgroundColor: isDarkMode ? const Color(0xFF030F0F) : AppTheme.primary,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            type: BottomNavigationBarType.fixed,
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
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menú'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
              BottomNavigationBarItem(icon: Icon(Icons.person_add_alt_1), label: 'Agregar'),
              BottomNavigationBarItem(icon: Icon(Icons.sync), label: 'Sincronizar'),
            ],
          ),
        ),
      ),
    );
  }

  // Panel de módulos
  Widget _buildModulesPanel() {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF030F0F) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 32),
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
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.8,
            ),
            itemCount: _modules.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Acción al seleccionar módulo
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? const Color(0x33161F49)
                        : AppTheme.primary.withOpacity(0.09),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        moduleIcons[_modules[index].name] ?? Icons.folder,
                        color: isDarkMode ? Colors.white : AppTheme.primary,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _modules[index].name,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : AppTheme.primary,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
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
              title: Text("Cambiar sede", style: GoogleFonts.montserrat(color: textColor, fontWeight: FontWeight.w500)),
              trailing: DropdownButton<String>(
                dropdownColor: isDarkMode ? const Color(0xFF161F49) : Colors.white,
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
                style: GoogleFonts.montserrat(color: textColor, fontWeight: FontWeight.w500),
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
              title: Text("Salir", style: GoogleFonts.montserrat(color: textColor, fontWeight: FontWeight.w500)),
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