import 'package:apuntes_upemor/screens/ajustes_pantalla.dart';
import 'package:apuntes_upemor/screens/detalle_pantalla.dart';
import 'package:apuntes_upemor/screens/inicio_pantalla.dart';
import 'package:apuntes_upemor/screens/pantalla_principal.dart';
import 'package:apuntes_upemor/screens/screen_not_found.dart';
import 'package:apuntes_upemor/screens/subir_pantalla.dart';
import 'package:flutter/material.dart';

/// Clase que centraliza todas las rutas de la aplicación.
/// Aquí se definen los nombres de ruta y a qué pantalla van.
class AppRoutes {
  /// Ruta inicial que se carga al abrir la app.
  static final initialRoute = "inicio";

  /// Mapa de rutas disponibles en la aplicación.
  /// La llave es el nombre de la ruta y el valor es la pantalla que se muestra.
  static Map<String, Widget Function(BuildContext)> rutas = {
    "inicio": (context) => PantallaPrincipal(),
    "lista": (context) => InicioPantalla(),
    "detalle": (context) => DetallePantalla(),
    "subir": (context) => SubirPantalla(),
    "ajustes": (context) => AjustesPantalla(),
  };

  /// Ruta por defecto cuando se intenta navegar a una ruta no definida.
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => ScreenNotFound());
  }
}