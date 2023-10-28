
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  SlideInfo(this.title, this.caption, this.imageUrl);
}

final slides = <SlideInfo>[
  SlideInfo('Pasos a Seguir', '', 'assets/images/3.png'),
  SlideInfo('Verificación de identidad', '- Entrega tu DUI\n- Verificación de registro y validación para votar\n- Confirmación valida\n- Genera el codigo QR', 'assets/images/4.png'),
  SlideInfo('Reafirmación de identidad y busqueda en el padrón electoral', '- Reafirmación de tu identidad\n- Busqueda de tu nombre en el padrón electoral\n- Confirmación valida', 'assets/images/5.png'),
  SlideInfo('Votación digital', '- Dirigete a la terminal de votación\n- Selecciona el candidato de preferencia\n- Tu voto sera registrado y enviado de forma electrónica', 'assets/images/6.png'),
  SlideInfo('Verificación final y firma del padr+on electoral', '- Regresa a la segunda estación de validación\n- Firma el padrón electoral en físico\n- Verifica que te sellen tu ticket QR\n- Marca tu dedo meñique\n- No olvides pedir tu DUI', 'assets/images/7.png'),
  SlideInfo('', '', 'assets/images/8.png'),
];


class Tutorial extends StatefulWidget {
  static const name = 'tutorial-screen';
  const Tutorial({super.key});

  @override
  State<Tutorial> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {

  final PageController pageviewController = PageController();
  bool endReached = false;

  @override
  void initState() {
    super.initState();

    pageviewController.addListener(() {
      final page = pageviewController.page ?? 0;
      if (!endReached && page>=(slides.length - 1.5)) {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: pageviewController,
            physics: const BouncingScrollPhysics(),
            children: slides.map((slideData) => _Slide(
              title: slideData.title, 
              caption: slideData.caption, 
              imageUrl: slideData.imageUrl
              )
            ).toList()
          ),
          Positioned(
            right: 20,
            top: 40,
            child: TextButton(
              child: const Text('Salir'),
              onPressed: () => context.pushReplacement('/'),
            ),
          ),
          endReached ? Positioned(
            bottom: 30,
            right: 30,
            child: FadeInRight(
              from: 15,
              delay: const Duration(seconds: 1),
              child: FilledButton(
                onPressed: () => context.pushReplacement('/'),
                child: const Text('Comenzar'),
              ),
            ),
          ) : const SizedBox()
        ],
      ),
    );
  }
}


class _Slide extends StatelessWidget {
  final String title;
  final String caption;
  final String imageUrl;
  const _Slide({
    required this.title, 
    required this.caption, 
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage(imageUrl),),
            const SizedBox(height: 20,),
            Text(title, style: titleStyle,),
            const SizedBox(height: 20,),
            Text(caption, style: captionStyle,)
          ],
        ),
      ),
    );
  }
}