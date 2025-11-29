import 'package:flutter/material.dart';
import '../models/apunte.dart';

/// Pantalla de detalle de un apunte.
/// Muestra la información completa del apunte que se seleccionó
/// en la lista (título, materia, cuatrimestre, descripción, etc.).
class DetallePantalla extends StatelessWidget {
  /// Decoración reutilizable para las tarjetas (contenedores blancos con borde).
  BoxDecoration _decoTarjeta() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.black26),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Se recupera el apunte enviado como argumento en la navegación.
    final args = ModalRoute.of(context)?.settings.arguments;
    final Apunte? apunte = args is Apunte ? args : null;

    /// Si no viene un apunte, se usan textos de ejemplo.
    final titulo = apunte?.titulo ?? 'U1 - Introducción a Flutter (PDF)';
    final infoLinea = apunte != null
        ? '${apunte.cuatrimestre} - ${apunte.materia} - ${apunte.fecha}'
        : '4A - Apuntes - 28/10/25';
    final descripcion = apunte != null && apunte.descripcion.trim().isNotEmpty
        ? apunte.descripcion
        : 'Sin descripción registrada.';
    final palabras = apunte != null && apunte.palabrasClave.trim().isNotEmpty
        ? apunte.palabrasClave
        : 'Sin palabras clave.';
    final publicoTexto = apunte == null
        ? 'Demo'
        : (apunte.publico ? 'Apunte público' : 'Apunte privado');
    final carrera = apunte?.carrera ?? 'Ing. en Sistemas';

    return Scaffold(
      appBar: AppBar(title: Text('Apuntes')),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 80),
        child: Column(
          children: [
            // Tarjeta con imagen y encabezado del apunte
            Container(
              decoration: _decoTarjeta(),
              padding: EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1588345921523-c2dcdb7f1dcd?q=80&w=600&auto=format&fit=crop',
                      width: 120,
                      height: 95,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titulo,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          infoLinea,
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),

            // Tarjeta con información general
            Container(
              decoration: _decoTarjeta(),
              padding: EdgeInsets.fromLTRB(18, 14, 18, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Información general',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Carrera: $carrera'),
                  Text('Materia: ${apunte?.materia ?? 'Materia de ejemplo'}'),
                  Text('Cuatrimestre: ${apunte?.cuatrimestre ?? '-'}'),
                  Text('Tipo de archivo: ${apunte?.tipoArchivo ?? '-'}'),
                  Text('Fecha: ${apunte?.fecha ?? '-'}'),
                ],
              ),
            ),
            SizedBox(height: 18),

            // Tarjeta con descripción, palabras clave y si es público/privado
            Container(
              decoration: _decoTarjeta(),
              padding: EdgeInsets.fromLTRB(18, 14, 18, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Descripción',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(descripcion),
                  SizedBox(height: 10),
                  Text(
                    'Palabras clave',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    palabras,
                    style: TextStyle(color: Colors.black54),
                  ),
                  SizedBox(height: 10),
                  Text(
                    publicoTexto,
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),

            // Zona de botones de acción (abrir, descargar, etc.)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black54),
              ),
              padding: EdgeInsets.fromLTRB(18, 22, 18, 22),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 28,
                runSpacing: 18,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                      shape: StadiumBorder(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 12,
                      ),
                    ),
                    child: Text('Abrir'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF93C5FD),
                      foregroundColor: Colors.white,
                      shape: StadiumBorder(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 12,
                      ),
                    ),
                    child: Text('Descargar'),
                  ),
                  ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 12,
                      ),
                    ),
                    child: Text('Guardar'),
                  ),
                  ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 12,
                      ),
                    ),
                    child: Text('Compartir'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}