import 'package:apuntes_upemor/provider/apuntes_provider.dart';
import 'package:apuntes_upemor/rutas/rutas.dart';
import 'package:apuntes_upemor/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Punto de entrada de la aplicación.
/// Aquí se inicializa el provider de apuntes y se cargan los datos de la BD
/// antes de mostrar la interfaz principal.
void main() {
  runApp(
    ChangeNotifierProvider(
      // Se crea el provider y se manda llamar cargarApuntes()
      // para traer los registros existentes en la base de datos.
      create: (_) => ApuntesProvider()..cargarApuntes(),
      child: AppApuntes(),
    ),
  );
}

/// Widget raíz de la aplicación de apuntes.
/// Configura el tema, las rutas y la pantalla inicial.
class AppApuntes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Tema principal de la app (colores, estilos de AppBar, etc.).
      theme: AppThemes.temaClaro,
      // Ruta inicial que se va a mostrar al abrir la app.
      initialRoute: AppRoutes.initialRoute,
      // Mapa de rutas con sus pantallas asociadas.
      routes: AppRoutes.rutas,
      // Ruta de respaldo en caso de que se intente navegar a una ruta inexistente.
      onGenerateRoute: (settings) => AppRoutes.onGenerateRoute(settings),
    );
  }
}