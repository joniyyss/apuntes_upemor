import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Clase auxiliar para manejar la base de datos local de la app.
/// Aquí se crea la tabla de apuntes y se hacen las operaciones básicas
/// como insertar, consultar y eliminar.
class DBHelper {
  static Database? _db;
  static const _dbName = 'apuntes.db';
  static const _dbVersion = 1;

  /// Obtiene la instancia de la base de datos.
  /// Si ya está abierta la regresa, si no la crea.
  static Future<Database> getDB() async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  /// Inicializa la base de datos y define el archivo físico donde se guarda.
  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreateDB,
    );
  }

  /// Se ejecuta solo la primera vez para crear la tabla de apuntes.
  static Future<void> _onCreateDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE apuntes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        carrera TEXT NOT NULL,
        cuatrimestre TEXT NOT NULL,
        materia TEXT NOT NULL,
        titulo TEXT NOT NULL,
        tipoArchivo TEXT NOT NULL,
        descripcion TEXT,
        palabrasClave TEXT,
        publico INTEGER NOT NULL,
        fecha TEXT NOT NULL
      );
    ''');
  }

  /// Inserta un nuevo apunte en la tabla y regresa el id generado.
  static Future<int> insertarApunte(Map<String, dynamic> data) async {
    final db = await getDB();
    return await db.insert('apuntes', data);
  }

  /// Obtiene todos los apuntes guardados, ordenados del más nuevo al más viejo.
  static Future<List<Map<String, dynamic>>> getApuntes() async {
    final db = await getDB();
    return await db.query('apuntes', orderBy: 'id DESC');
  }

  /// Elimina un apunte según su id.
  static Future<void> eliminarApunte(int id) async {
    final db = await getDB();
    await db.delete('apuntes', where: 'id = ?', whereArgs: [id]);
  }
}