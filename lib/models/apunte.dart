/// Modelo que representa un apunte guardado en la aplicación.
/// Esta clase se usa para manejar los datos que van y vienen de la base de datos.
class Apunte {
  final int? id;
  final String carrera;
  final String cuatrimestre;
  final String materia;
  final String titulo;
  final String tipoArchivo;
  final String descripcion;
  final String palabrasClave;
  final bool publico;
  final String fecha;

  Apunte({
    this.id,
    required this.carrera,
    required this.cuatrimestre,
    required this.materia,
    required this.titulo,
    required this.tipoArchivo,
    required this.descripcion,
    required this.palabrasClave,
    required this.publico,
    required this.fecha,
  });

  /// Convierte el objeto Apunte a un mapa para poder guardarlo en la base de datos.
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "carrera": carrera,
      "cuatrimestre": cuatrimestre,
      "materia": materia,
      "titulo": titulo,
      "tipoArchivo": tipoArchivo,
      "descripcion": descripcion,
      "palabrasClave": palabrasClave,
      "publico": publico ? 1 : 0,
      "fecha": fecha,
    };
  }

  /// Crea un objeto Apunte a partir de un mapa obtenido de la base de datos.
  factory Apunte.fromMap(Map<String, dynamic> m) {
    return Apunte(
      id: m["id"] as int?,
      carrera: (m["carrera"] ?? "").toString(),
      cuatrimestre: (m["cuatrimestre"] ?? "").toString(),
      materia: (m["materia"] ?? "").toString(),
      titulo: (m["titulo"] ?? "").toString(),
      tipoArchivo: (m["tipoArchivo"] ?? "").toString(),
      descripcion: (m["descripcion"] ?? "").toString(),
      palabrasClave: (m["palabrasClave"] ?? "").toString(),
      publico: (m["publico"] ?? 0) == 1,
      fecha: (m["fecha"] ?? "").toString(),
    );
  }
}