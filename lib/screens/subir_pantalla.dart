import 'package:apuntes_upemor/models/apunte.dart';
import 'package:apuntes_upemor/provider/apuntes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Pantalla donde el usuario llena el formulario
/// para registrar un nuevo apunte en la base de datos.
class SubirPantalla extends StatefulWidget {
  @override
  State<SubirPantalla> createState() => _EstadoSubirPantalla();
}

/// Estado de la pantalla de subir apunte.
/// Aquí se controla el formulario, los switches y el guardado.
class _EstadoSubirPantalla extends State<SubirPantalla> {
  final Color textoOscuro = Color(0xFF212121);

  /// Indica si el apunte será público.
  bool publico = false;

  /// Indica si el usuario aceptó los términos.
  bool acepto = false;

  /// Controladores para leer los textos de los campos.
  final TextEditingController cuatriCtrl = TextEditingController();
  final TextEditingController materiaCtrl = TextEditingController();
  final TextEditingController tituloCtrl = TextEditingController();
  final TextEditingController tipoCtrl = TextEditingController();
  final TextEditingController descripcionCtrl = TextEditingController();
  final TextEditingController palabrasCtrl = TextEditingController();

  @override
  void dispose() {
    cuatriCtrl.dispose();
    materiaCtrl.dispose();
    tituloCtrl.dispose();
    tipoCtrl.dispose();
    descripcionCtrl.dispose();
    palabrasCtrl.dispose();
    super.dispose();
  }

  /// Decoración genérica para las tarjetas (containers grandes).
  BoxDecoration _decoTarjeta() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.black26),
    );
  }

  /// Decoración genérica para los TextFormField del formulario.
  InputDecoration _decoEntrada({
    required String hintText,
    IconData? icono,
  }) {
    final borde = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Colors.black26),
    );
    return InputDecoration(
      hintText: hintText,
      prefixIcon: icono != null ? Icon(icono, color: Colors.blue) : null,
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: borde,
      enabledBorder: borde,
      focusedBorder: borde,
    );
  }

  /// Pequeño helper para crear campos de texto con el mismo estilo.
  Widget _campoTexto({
    required String hint,
    IconData? icono,
    TextEditingController? controller,
    bool soloLectura = false,
    TextInputType tipo = TextInputType.text,
    int maxLines = 1,
    String? valorFijo,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        readOnly: soloLectura,
        initialValue: controller == null ? valorFijo : null,
        keyboardType: tipo,
        maxLines: maxLines,
        decoration: _decoEntrada(hintText: hint, icono: icono),
      ),
    );
  }

  /// Muestra un cuadro de diálogo sencillo con título y mensaje.
  void _mostrarDialogo(String titulo, String mensaje) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Aceptar'),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        );
      },
    );
  }

  /// Valida los datos del formulario, crea el objeto [Apunte]
  /// y lo manda al provider para guardarlo en la base de datos.
  Future<void> subirApunte() async {
    if (!acepto) {
      _mostrarDialogo('Aviso', 'Debes aceptar los términos y condiciones');
      return;
    }

    final cuatri = cuatriCtrl.text.trim();
    final materia = materiaCtrl.text.trim();
    final titulo = tituloCtrl.text.trim();
    final tipo = tipoCtrl.text.trim();
    final desc = descripcionCtrl.text.trim();
    final palabras = palabrasCtrl.text.trim();

    if (cuatri.isEmpty ||
        materia.isEmpty ||
        titulo.isEmpty ||
        tipo.isEmpty ||
        desc.isEmpty ||
        palabras.isEmpty) {
      _mostrarDialogo('Aviso', 'Completa todos los campos del formulario');
      return;
    }

    final cuatriNum = int.tryParse(cuatri);
    if (cuatriNum == null || cuatriNum < 1 || cuatriNum > 12) {
      _mostrarDialogo(
        'Aviso',
        'El cuatrimestre debe ser un número entre 1 y 12',
      );
      return;
    }

    final fechaHoy = DateTime.now();
    final fechaStr =
        '${fechaHoy.year.toString().padLeft(4, '0')}-${fechaHoy.month.toString().padLeft(2, '0')}-${fechaHoy.day.toString().padLeft(2, '0')}';

    final apunte = Apunte(
      carrera: 'Ing. en Sistemas',
      cuatrimestre: cuatri,
      materia: materia,
      titulo: titulo,
      tipoArchivo: tipo,
      descripcion: desc,
      palabrasClave: palabras,
      publico: publico,
      fecha: fechaStr,
    );

    final provider = Provider.of<ApuntesProvider>(context, listen: false);
    await provider.agregarApunte(apunte);

    _mostrarDialogo('Éxito', 'Apunte guardado en la base de datos');

    cuatriCtrl.clear();
    materiaCtrl.clear();
    tituloCtrl.clear();
    tipoCtrl.clear();
    descripcionCtrl.clear();
    palabrasCtrl.clear();
    setState(() {
      publico = false;
      acepto = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tarjeta de contexto del apunte
          Container(
            decoration: _decoTarjeta(),
            padding: EdgeInsets.fromLTRB(16, 18, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Completa los datos del apunte',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: textoOscuro,
                  ),
                ),
                SizedBox(height: 6),
                Text('Contexto', style: TextStyle(color: Colors.black54)),
                SizedBox(height: 14),
                _campoTexto(
                  hint: 'Ing. en Sistemas',
                  icono: Icons.school,
                  soloLectura: true,
                  valorFijo: 'Ing. en Sistemas',
                ),
                _campoTexto(
                  hint: 'Cuatrimestre (1 a 12)',
                  icono: Icons.numbers,
                  tipo: TextInputType.number,
                  controller: cuatriCtrl,
                ),
                _campoTexto(
                  hint: 'Materia',
                  icono: Icons.menu_book_rounded,
                  controller: materiaCtrl,
                ),
              ],
            ),
          ),
          SizedBox(height: 18),

          // Tarjeta de detalles del apunte
          Container(
            decoration: _decoTarjeta(),
            padding: EdgeInsets.fromLTRB(16, 18, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detalles',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: textoOscuro,
                  ),
                ),
                SizedBox(height: 14),
                _campoTexto(
                  hint: 'Título del apunte',
                  icono: Icons.title,
                  controller: tituloCtrl,
                ),
                _campoTexto(
                  hint: 'Tipo de archivo (PDF / Imagen / Link)',
                  icono: Icons.attach_file,
                  controller: tipoCtrl,
                ),
                _campoTexto(
                  hint: 'Descripción breve (máx. 3 líneas)',
                  icono: Icons.notes_rounded,
                  maxLines: 3,
                  controller: descripcionCtrl,
                ),
                _campoTexto(
                  hint: 'Palabras clave (ej: flutter, widgets, unidad 1)',
                  icono: Icons.sell_outlined,
                  controller: palabrasCtrl,
                ),
                SizedBox(height: 6),
                Text(
                  'Sugerencia: separa por comas para facilitar la búsqueda.',
                  style: TextStyle(color: Colors.black45),
                ),
                SizedBox(height: 10),
                SwitchListTile(
                  title: Text('Hacer público'),
                  subtitle: Text('Tu apunte será visible para otros'),
                  value: publico,
                  onChanged: (v) => setState(() => publico = v),
                ),
                CheckboxListTile(
                  value: acepto,
                  onChanged: (v) => setState(() => acepto = v ?? false),
                  title: Text(
                    'Acepto los términos y confirmo que el contenido es mío',
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ],
            ),
          ),
          SizedBox(height: 22),

          // Botones de acción del formulario
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () {
                  cuatriCtrl.clear();
                  materiaCtrl.clear();
                  tituloCtrl.clear();
                  tipoCtrl.clear();
                  descripcionCtrl.clear();
                  palabrasCtrl.clear();
                  setState(() {
                    publico = false;
                    acepto = false;
                  });
                },
                child: Text('Cancelar'),
              ),
              SizedBox(width: 12),
              ElevatedButton(
                onPressed: subirApunte,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  shape: StadiumBorder(),
                ),
                child: Text('Subir apunte'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}