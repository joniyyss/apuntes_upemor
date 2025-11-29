import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/apunte.dart';

/// Provider que maneja la lista de apuntes.
/// Se encarga de cargar, agregar y eliminar apuntes en la base de datos
/// y de notificar a la interfaz cuando hay cambios.
class ApuntesProvider extends ChangeNotifier {
  /// Lista de apuntes que se muestran en la app.
  List<Apunte> _apuntes = [];

  /// Lista pública de solo lectura para usar en los widgets.
  List<Apunte> get apuntes => _apuntes;

  /// Carga todos los apuntes desde la base de datos y actualiza la lista.
  Future<void> cargarApuntes() async {
    final data = await DBHelper.getApuntes();
    _apuntes = data.map((m) => Apunte.fromMap(m)).toList();

    debugPrint('----- Apuntes cargados desde la BD -----');
    for (final a in _apuntes) {
      debugPrint(
          'id=${a.id} | titulo=${a.titulo} | materia=${a.materia} | cuatrimestre=${a.cuatrimestre}');
    }
    debugPrint('Total apuntes: ${_apuntes.length}');
    debugPrint('----------------------------------------');

    notifyListeners();
  }

  /// Inserta un nuevo apunte en la base de datos y recarga la lista.
  Future<void> agregarApunte(Apunte a) async {
    final id = await DBHelper.insertarApunte(a.toMap());
    debugPrint('Nuevo apunte insertado con id: $id');

    await cargarApuntes();
  }

  /// Elimina un apunte por su id y recarga la lista.
  Future<void> eliminarApuntePorId(int id) async {
    await DBHelper.eliminarApunte(id);
    debugPrint('Apunte eliminado con id: $id');

    await cargarApuntes();
  }
}