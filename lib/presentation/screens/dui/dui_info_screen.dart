import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_tesina/config/menu/menu_items.dart';
import 'package:proyecto_tesina/presentation/widgets/input.dart';

import '../../providers/dui/dui_provider.dart';

class DuiInfoScreen extends StatelessWidget {
  static const name = 'info-screen';
  const DuiInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos de votacion'),
      ),
      body: const _InfoView(),
    );
  }
}

class _InfoView extends ConsumerWidget {
  const _InfoView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verDui = ref.watch(duiInfoProvider);
    return Container(
      color: Colors.transparent,
      height: double.infinity,
      width: double.infinity,
      //padding: const EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              width: double.infinity,
              child: const Image(
                image: AssetImage(
                    'assets/images/Tse_logo.png'), // Ruta de la imagen desde los recursos locales
                width: 100, // Ancho deseado de la imagen
                height: 100, // Alto deseado de la imagen
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white70,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.blue, // Establece el color de fondo azul
                        padding: const EdgeInsets.all(
                            16.0), // Espacio interno alrededor del texto
                        child: const FittedBox(
                          child: Text(
                            'VERIFICA TUS DATOS ELECTORALES',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Input(texto: 'DUI', dato: verDui!.dui),
                      Input(texto: 'NOMBRE', dato: verDui.nombre),
                      Input(texto: 'DEPARTAMENTO', dato: verDui.departamento),
                      Input(texto: 'MUNICIPIO', dato: verDui.municipio),
                      Input(
                          texto: 'CENTRO DE VOTACION',
                          dato: verDui.centrodevotacion),
                      Input(texto: 'DIRECCION', dato: verDui.direccion),
                      Input(texto: 'JRV', dato: verDui.jrv),
                      Input(texto: 'CORRELATIVO', dato: verDui.correlativo),
                      const SizedBox(height: 5.0),
                      Container(
                        width: double
                            .infinity, // Ocupa todo el ancho de la pantalla
                        color: Colors
                            .transparent, // Establece el color de fondo gris
                        padding: const EdgeInsets.all(
                            1.0), // Espacio interno alrededor del contenido
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Alinea los elementos al centro horizontalmente
                          children: [
                            // Espacio entre los botones
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(Colors
                                          .blue), // Cambia "Colors.blue" al color que desees
                                ),
                                onPressed: () {
                                  final menuItem = appMenuItems[0].link;
                                  context.push(menuItem);
                                },
                                child: const Text('Aceptar'),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
