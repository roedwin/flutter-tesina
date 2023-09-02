import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_tesina/infraestructure/datasources/duidb_datasource.dart';
import 'package:proyecto_tesina/presentation/providers/dui/dui_provider.dart';

import '../../../config/menu/menu_items.dart';

class DuiScreen extends StatelessWidget {
  static const name = 'dui-screen';
  const DuiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Verificar Dui'),
        ),
        body: const _DuiView());
  }
}

class _DuiView extends ConsumerWidget {
  const _DuiView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _duiController = TextEditingController();

    String dui = '98765432-1';

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          width: double.infinity,
          child: const Image(
            image: AssetImage(
                'assets/images/Tse_logo.png'), // Ruta de la imagen desde los recursos locales
            width: 200, // Ancho deseado de la imagen
            height: 200, // Alto deseado de la imagen
          ),
        ),
        Column(children: [
          Container(
            width: double.infinity,
            color: Colors.blue, // Establece el color de fondo azul
            padding: const EdgeInsets.all(
                16.0), // Espacio interno alrededor del texto
            child: const Text(
              'VERIFICA TUS DATOS ELECTORALES',
              style: TextStyle(
                color: Colors.white, // Establece el color del texto en blanco
                fontSize: 24.0, // Tamaño de fuente del texto
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Ingrese el numero de DUI',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: _duiController,
              keyboardType: TextInputType.number,
              inputFormatters: [DuiInputFormatter()],
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                hintText: 'DUI (12345678-9)',
                hintStyle: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey, // Color de texto del placeholder
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              ),
              onChanged: (value) {
                dui = value;
              },
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            width: double.infinity, // Ocupa todo el ancho de la pantalla
            color: Colors.grey, // Establece el color de fondo gris
            padding: const EdgeInsets.all(
                16.0), // Espacio interno alrededor del contenido
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .center, // Alinea los elementos al centro horizontalmente
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey
                        .shade700, // Establece el color gris como fondo del botón
                  ),
                  child: const Text('CANCELAR'),
                ),
                const SizedBox(width: 16.0), // Espacio entre los botones
                ElevatedButton(
                  onPressed: () async {
                    final verDui = DuidbDatasource();
                    final datos = await verDui.getData(dui);

                    ref.read(duiInfoProvider.notifier).state = datos;

                    final menuItem = appMenuItems[2].link;
                    context.push(menuItem);
                  },
                  child: const Text('CONSULTAR'),
                ),
              ],
            ),
          ),
        ]),
      ],
    );
  }
}

class DuiInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final StringBuffer newText = StringBuffer();
    final String trimmedText = newValue.text.replaceAll('-', '');

    for (int i = 0; i < trimmedText.length; i++) {
      newText.write(trimmedText[i]);
      if (i == 7) {
        newText.write('-');
      }
    }

    return newValue.copyWith(
      text: newText.toString().toUpperCase(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
