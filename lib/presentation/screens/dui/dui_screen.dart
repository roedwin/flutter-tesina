// ignore_for_file: use_build_context_synchronously

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

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              width: double.infinity,
              child: const Image(
                image: AssetImage(
                    'assets/images/Tse_logo.png'), // Ruta de la imagen desde los recursos locales
                width: 200, // Ancho deseado de la imagen
                height: 200, // Alto deseado de la imagen
              ),
            ),
            Card(
              elevation: 5,
              color: Colors.white70,
              child: Column(children: [
                Container(
                  width: double.infinity,
                  color: Colors.blue, // Establece el color de fondo azul
                  padding: const EdgeInsets.all(
                      16.0), // Espacio interno alrededor del texto
                  child: const FittedBox(
                    child: Text(
                      'VERIFICA TUS DATOS ELECTORALES',
                      style: TextStyle(
                        color: Colors.white, // Tamaño de fuente del texto
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Ingrese el numero de DUI',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    controller: _duiController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [DuiInputFormatter()],
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: '01234567-8',
                      hintStyle: TextStyle(
                        fontSize: 18.0,
                        color: Colors.blueGrey, // Color de texto del placeholder
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                    ),
                    onChanged: (value) {
                      dui = value;
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  width: double.infinity, // Ocupa todo el ancho de la pantalla
                  color: Colors.transparent, // Establece el color de fondo gris
                  padding: const EdgeInsets.all(
                      5.0), // Espacio interno alrededor del contenido
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Alinea los elementos al centro horizontalmente
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.pop();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors
                              .grey), // Cambia "Colors.blue" al color que desees
                        ),
                        child: const Text(
                          'CANCELAR',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 16.0), // Espacio entre los botones
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors
                              .blue), // Cambia "Colors.blue" al color que desees
                        ),
                        onPressed: () async {
                          final verDui = DuidbDatasource();
                          if (dui.isEmpty) {
                            showAlertDialog(
                                context, "Alerta", "Ingresa un numero de DUI", onOkPressed: (){});
                          }
                          final datos = await verDui.getData(dui);

                          ref
                              .read(duiInfoProvider.notifier)
                              .update((state) => state = datos);


                          if (datos == null) {
                            showAlertDialog(
                              context,
                              "Alerta",
                              "Dui no encontrado",
                              onOkPressed: () {
                                final menuItem = appMenuItems[0].link;
                                context.pushReplacement(menuItem);
                              },
                            );
                            return;
                          }

                          final menuItem = appMenuItems[4].link;
                          context.pushReplacement(menuItem);
                          
                        },
                        child: const Text(
                          'CONSULTAR',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
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

showAlertDialog(BuildContext context, String title, String content,
    {VoidCallback? onOkPressed}) {
  // set up the button
  Widget okButton = TextButton(
    onPressed: () {
      final menuItem = appMenuItems[0].link;
      context.pushReplacement(menuItem);
    },
    child: const Text(
        "OK"), // Si onOkPressed es nulo, asigna una función vacía como predeterminada
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
