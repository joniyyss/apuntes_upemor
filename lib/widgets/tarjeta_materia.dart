import 'package:flutter/material.dart';

/// Tarjeta genérica para mostrar información de una materia/apunte
/// con una imagen, título, subtítulo y una acción al tocarla.
class TarjetaMateria extends StatelessWidget {
  /// URL de la imagen que se muestra en la parte izquierda de la tarjeta.
  final String img;

  /// Título principal de la tarjeta (por ejemplo, nombre de la materia).
  final String titulo;

  /// Texto secundario (por ejemplo, número de apuntes o descripción corta).
  final String subtitulo;

  /// Función opcional que se ejecuta cuando el usuario toca la tarjeta.
  final Function()? onTap;

  TarjetaMateria({
    required this.img,
    required this.titulo,
    required this.subtitulo,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Permite que la tarjeta sea "clickeable".
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black12),
        ),
        padding: EdgeInsets.all(14),
        child: Row(
          children: [
            // Imagen de la materia o del apunte.
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                img,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            // Columna con el título y subtítulo.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    subtitulo,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
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