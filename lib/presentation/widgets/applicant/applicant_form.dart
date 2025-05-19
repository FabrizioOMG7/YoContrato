import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicantForm extends StatefulWidget {
  const ApplicantForm({super.key});

  @override
  State<ApplicantForm> createState() => _ApplicantFormState();
}

class _ApplicantFormState extends State<ApplicantForm> {
  final _formKey = GlobalKey<FormState>();

  // Ejemplo de controladores para los campos
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();

  @override
  void dispose() {
    _dniController.dispose();
    _nombresController.dispose();
    _apellidosController.dispose();
    _celularController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: isDarkMode ? const Color(0xFF161F49) : Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      hintStyle: GoogleFonts.montserrat(
        color: isDarkMode ? Colors.white54 : Colors.black38,
        fontSize: 15,
      ),
    );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sede y eventos disponibles (simulado como en tu imagen)
          Container(
            margin: const EdgeInsets.only(bottom: 18),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF161F49) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('C5 NORTE', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 16, color: isDarkMode ? Colors.white : Colors.black87)),
                const SizedBox(height: 4),
                Text('EVENTOS DISPONIBLES', style: GoogleFonts.montserrat(fontSize: 14, color: isDarkMode ? Colors.white70 : Colors.black54)),
              ],
            ),
          ),
          // Campos del formulario
          TextFormField(
            controller: _dniController,
            decoration: inputDecoration.copyWith(labelText: 'DNI'),
            keyboardType: TextInputType.number,
            validator: (value) => value == null || value.isEmpty ? 'Ingrese DNI' : null,
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _nombresController,
            decoration: inputDecoration.copyWith(labelText: 'Nombres'),
            validator: (value) => value == null || value.isEmpty ? 'Ingrese nombres' : null,
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _apellidosController,
            decoration: inputDecoration.copyWith(labelText: 'Apellidos'),
            validator: (value) => value == null || value.isEmpty ? 'Ingrese apellidos' : null,
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _celularController,
            decoration: inputDecoration.copyWith(labelText: 'Celular'),
            keyboardType: TextInputType.phone,
            validator: (value) => value == null || value.isEmpty ? 'Ingrese celular' : null,
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.save_alt),
              label: Text(
                'Registrar',
                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 2,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Aquí puedes mostrar un SnackBar o navegar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Postulante registrado')),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}