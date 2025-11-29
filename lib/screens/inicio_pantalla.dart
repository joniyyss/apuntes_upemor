import 'package:apuntes_upemor/provider/apuntes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/tarjeta_materia.dart';
import '../models/apunte.dart';

/// Pantalla de inicio de la app.
/// Muestra un buscador, algunas materias de ejemplo
/// y debajo los apuntes que vienen desde la base de datos.
class InicioPantalla extends StatelessWidget {
  final Color textoOscuro = Color(0xFF212121);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Caja de búsqueda (solo visual por ahora)
          TextField(
            decoration: InputDecoration(
              hintText: 'Buscar materia...',
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {},
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 12),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: Colors.black12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: Colors.black26),
              ),
            ),
          ),
          SizedBox(height: 20),
          // Mensaje de bienvenida
          Text(
            'Hola, Jonathan',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: textoOscuro,
            ),
          ),
          SizedBox(height: 4),
          Text('Toca una materia para consultar sus apuntes'),
          SizedBox(height: 6),
          Divider(thickness: 1),
          SizedBox(height: 16),

          // Tarjetas estáticas de ejemplo
          TarjetaMateria(
            img:
                'https://images.unsplash.com/photo-1526285759904-71d1170ed2ac?q=80&w=600&auto=format&fit=crop',
            titulo: 'Cálculo Integral',
            subtitulo: '12 apuntes',
            onTap: () => Navigator.pushNamed(context, 'detalle'),
          ),
          TarjetaMateria(
            img:
                'https://images.unsplash.com/photo-1555066931-4365d14bab8c?q=80&w=600&auto=format&fit=crop',
            titulo: 'POO',
            subtitulo: '9 apuntes',
            onTap: () => Navigator.pushNamed(context, 'detalle'),
          ),
          TarjetaMateria(
            img:
                'https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=600&auto=format&fit=crop',
            titulo: 'Aplicaciones móviles',
            subtitulo: '7 apuntes',
            onTap: () => Navigator.pushNamed(context, 'detalle'),
          ),

          SizedBox(height: 24),

          /// Sección dinámica: apuntes que vienen desde la BD
          /// usando el provider ApuntesProvider.
          Consumer<ApuntesProvider>(
            builder: (context, prov, _) {
              if (prov.apuntes.isEmpty) {
                return Text(
                  'Todavía no hay apuntes guardados en la base de datos',
                  style: TextStyle(color: Colors.black54),
                );
              }

              // Imagen que se usará para todos los apuntes de la BD
              final imagenBD =
                  'https://images.unsplash.com/photo-1588345921523-c2dcdb7f1dcd?q=80&w=600&auto=format&fit=crop';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Apuntes guardados',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textoOscuro,
                    ),
                  ),
                  SizedBox(height: 8),
                  Column(
                    children: prov.apuntes.map((apunte) {
                      return _TarjetaApunteBD(
                        apunte: apunte,
                        img: imagenBD,
                        onTap: () {
                          // Navega a la pantalla de detalle con el apunte como argumento
                          Navigator.pushNamed(
                            context,
                            'detalle',
                            arguments: apunte,
                          );
                        },
                        onDelete: () {
                          // Elimina el apunte por id usando el provider
                          if (apunte.id == null) return;
                          prov.eliminarApuntePorId(apunte.id!);
                        },
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Tarjeta para mostrar un apunte que viene desde la base de datos.
/// Incluye imagen, título, materia, cuatrimestre y un botón para borrar.
class _TarjetaApunteBD extends StatelessWidget {
  final Apunte apunte;
  final String img;
  final Function() onTap;
  final Function() onDelete;

  _TarjetaApunteBD({
    required this.apunte,
    required this.img,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      padding: EdgeInsets.all(14),
      child: Row(
        children: [
          // Imagen clickeable
          InkWell(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                img,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          // Texto y descripción del apunte
          Expanded(
            child: InkWell(
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    apunte.titulo,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '${apunte.materia} • ${apunte.cuatrimestre}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 4),
                  if (apunte.descripcion.trim().isNotEmpty)
                    Text(
                      apunte.descripcion,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black45),
                    ),
                ],
              ),
            ),
          ),
          // Botón para eliminar el apunte
          IconButton(
            onPressed: onDelete,
            icon: Icon(
              Icons.delete_outline,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}