# Apuntes UPEMOR

Este repositorio solo incluye la carpeta lib y archivos de configuración principales (pubspec.yaml, README.md).
El resto de carpetas (android, ios, web, etc.) son las que genera Flutter por defecto al crear el proyecto.

Aplicación móvil hecha en **Flutter** para gestionar y compartir apuntes de materias de la carrera.  
Permite registrar apuntes con información como carrera, cuatrimestre, materia, tipo de archivo y si es público o no.  
Los apuntes se guardan en una base de datos local usando **SQLite**.

## Características principales

- Pantalla de inicio con lista de materias y apuntes guardados.
- Formulario para **subir apuntes** con:
  - Carrera
  - Cuatrimestre
  - Materia
  - Título del apunte
  - Tipo de archivo (texto descriptivo)
  - Descripción
  - Palabras clave
  - Opción de marcar como público
- Listado de apuntes almacenados en la base de datos.
- Pantalla de detalle para ver la información de un apunte.
- Uso de `Provider` para la gestión de estado.
- Uso de `sqflite` para la base de datos local.

## Requisitos

- Tener instalado:
  - [Flutter SDK](https://flutter.dev/docs/get-started/install)
  - Un editor como **Android Studio** o **VS Code**
  - Un emulador o dispositivo físico conectado

## Dependencias usadas

En el archivo `pubspec.yaml` se usan las siguientes librerías principales:

- `flutter`
- `provider` → manejo de estado (ApuntesProvider)
- `sqflite` → base de datos SQLite local
- `path` → manejo de rutas para ubicar el archivo de la base de datos
- `intl` → manejo de formatos de fecha (si se requiere)

