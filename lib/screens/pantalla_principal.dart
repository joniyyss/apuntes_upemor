import 'package:apuntes_upemor/screens/ajustes_pantalla.dart';
import 'package:apuntes_upemor/screens/inicio_pantalla.dart';
import 'package:apuntes_upemor/screens/subir_pantalla.dart';
import 'package:flutter/material.dart';

/// Pantalla principal de la app.
/// Aquí se maneja el AppBar y la navegación inferior
/// entre Inicio, Subir apunte y Ajustes.
class PantallaPrincipal extends StatefulWidget {
  @override
  State<PantallaPrincipal> createState() => _EstadoPantallaPrincipal();
}

/// Estado de la pantalla principal.
/// Controla qué pestaña del BottomNavigationBar está seleccionada.
class _EstadoPantallaPrincipal extends State<PantallaPrincipal> {
  /// Índice actual del BottomNavigationBar.
  int indice = 0;

  /// Color azul claro usado en el AppBar y la barra inferior.
  final Color azulClaro = Color(0xFF6EE7F0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior con título y avatar
      appBar: AppBar(
        backgroundColor: azulClaro,
        centerTitle: true,
        title: Text('Apuntes'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Text(
                'J',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),

      // Contenido que cambia según la pestaña seleccionada
      body: IndexedStack(
        index: indice,
        children: [
          InicioPantalla(),   // Página de inicio y listado de apuntes
          SubirPantalla(),    // Formulario para subir un nuevo apunte
          AjustesPantalla(),  // Pantalla de ajustes
        ],
      ),

      // Navegación inferior entre las 3 secciones principales
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indice,
        onTap: (i) => setState(() => indice = i),
        backgroundColor: azulClaro,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_upload_outlined),
            label: 'Subir',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }
}