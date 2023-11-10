import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_tesina/presentation/providers/theme/theme_provider.dart';
import 'package:proyecto_tesina/presentation/providers/tutorial/mostrar_tutorial_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  SlideInfo(this.title, this.caption, this.imageUrl);
}

final slides = <SlideInfo>[
  SlideInfo('Pasos a Seguir', '', 'assets/images/3.png'),
  SlideInfo(
      'Verificación de identidad',
      '- Entrega tu DUI\n- Verificación de registro y validación para votar\n- Confirmación valida\n- Genera el codigo QR',
      'assets/images/4.png'),
  SlideInfo(
      'Reafirmación de identidad y busqueda en el padrón electoral',
      '- Reafirmación de tu identidad\n- Busqueda de tu nombre en el padrón electoral\n- Confirmación valida',
      'assets/images/5.png'),
  SlideInfo(
      'Votación digital',
      '- Dirigete a la terminal de votación\n- Selecciona el candidato de preferencia\n- Tu voto sera registrado y enviado de forma electrónica',
      'assets/images/6.png'),
  SlideInfo(
      'Verificación final y firma del padrón electoral',
      '- Regresa a la segunda estación de validación\n- Firma el padrón electoral en físico\n- Verifica que te sellen tu ticket QR\n- Marca tu dedo meñique\n- No olvides pedir tu DUI',
      'assets/images/7.png'),
  SlideInfo('', '', 'assets/images/8.png'),
];

class Tutorial extends ConsumerStatefulWidget {
  static const name = 'tutorial-screen';
  const Tutorial({super.key});

  @override
  TutorialState createState() => TutorialState();
}

class TutorialState extends ConsumerState<Tutorial> {
  final PageController pageviewController = PageController();
  bool endReached = false;

  @override
  void initState() {
    super.initState();

    pageviewController.addListener(() {
      final page = pageviewController.page ?? 0;
      if (!endReached && page >= (slides.length - 1.5)) {
        setState(() {
          endReached = true;
        });
      }
    });
  }

  @override
  void dispose() {
    pageviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(isDarkModeProvider);
    final tutorialMostrado = ref.watch(mostrarTutorialProvider);
    return Scaffold(
      backgroundColor: isDark ? Colors.transparent : Colors.white,
      body: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 1)), // Espera 2 segundos
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return Stack(
                  children: [
                    PageView(
                        controller: pageviewController,
                        physics: const BouncingScrollPhysics(),
                        children: slides
                            .map((slideData) => _Slide(
                                title: slideData.title,
                                caption: slideData.caption,
                                imageUrl: slideData.imageUrl))
                            .toList()),
                    tutorialMostrado
                        ? Positioned(
                            right: 20,
                            top: 40,
                            child: TextButton(
                              child: const Text(
                                'Salir',
                                style: TextStyle(color: Colors.blue),
                              ),
                              onPressed: () => context.pushReplacement('/'),
                            ),
                          )
                        : const SizedBox(),
                    endReached
                        ? Positioned(
                            bottom: 30,
                            right: 30,
                            child: FadeInRight(
                              from: 15,
                              delay: const Duration(seconds: 1),
                              child: FilledButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(Colors
                                          .blue), // Cambia "Colors.blue" al color que desees
                                ),
                                onPressed: () {
                                  ref
                                      .read(mostrarTutorialProvider.notifier)
                                      .checkTutorialStatus();
                                  context.pushReplacement('/');
                                },
                                child: const Text('Comenzar',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                );
            }
          }),
    );
  }
}

class _Slide extends StatelessWidget {
  final String title;
  final String caption;
  final String imageUrl;
  const _Slide(
      {required this.title, required this.caption, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    //final titleStyle = TextStyle(color: Colors.black, fontSize: 25);
    final captionStyle = Theme.of(context).textTheme.bodySmall;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: AssetImage(imageUrl),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: titleStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              caption,
              style: captionStyle,
            )
          ],
        ),
      ),
    );
  }
}
