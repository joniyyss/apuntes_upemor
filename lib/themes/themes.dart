import 'package:flutter/material.dart';

/// Configura los temas generales de la aplicación (claro y oscuro).
class AppThemes {
  /// Color principal que se usa como base para el tema.
  static Color colorPrincipal = Color(0xFF6EE7F0);

  /// Tema claro principal de la app:
  /// define colores, estilo del AppBar y botones flotantes.
  static final temaClaro = ThemeData.light().copyWith(
    // Se deshabilitan las animaciones de splash/hover por defecto.
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,

    // Paleta de colores basada en el color principal.
    colorScheme: ColorScheme.fromSeed(seedColor: colorPrincipal),

    // Estilos globales para las barras de aplicación (AppBar).
    appBarTheme: AppBarTheme(
      backgroundColor: colorPrincipal,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        letterSpacing: 1,
        fontSize: 20,
      ),
      iconTheme: IconThemeData(color: Colors.black87),
    ),

    // Estilo base para los FloatingActionButton.
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorPrincipal,
      foregroundColor: Colors.white,
      elevation: 1,
    ),
  );

  /// Tema oscuro base (por ahora sin personalización extra).
  static final temaOscuro = ThemeData.dark().copyWith();
}