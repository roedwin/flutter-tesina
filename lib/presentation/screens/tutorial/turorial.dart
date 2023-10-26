
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
  SlideInfo('Pasos', 'Eu nostrud culpa dolore amet consequat pariatur eiusmod labore sit aliqua.', 'assets/images/3.png'),
  SlideInfo('Verificacion de identidad', 'Fugiat aliquip cillum ad enim sint proident est in eiusmod aliquip ad officia.', 'assets/images/4.png'),
  SlideInfo('Busqueda de patron electoral', 'Deserunt ullamco quis pariatur laboris adipisicing cupidatat proident dolore mollit qui.', 'assets/images/5.png'),
  SlideInfo('Votacion digital', 'Laborum sint laborum irure consequat ipsum magna laboris qui exercitation adipisicing.', 'assets/images/6.png'),
  SlideInfo('Firma del patron electoral', 'Voluptate officia ut duis adipisicing tempor consectetur cupidatat dolor elit dolor.', 'assets/images/7.png'),
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
              onPressed: () => context.pop(),
            ),
          ),
          endReached ? Positioned(
            bottom: 30,
            right: 30,
            child: FadeInRight(
              from: 15,
              delay: const Duration(seconds: 1),
              child: FilledButton(
                onPressed: () => context.pop(),
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