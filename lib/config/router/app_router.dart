import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_tesina/presentation/providers/theme/theme_provider.dart';
import 'package:proyecto_tesina/presentation/providers/tutorial/mostrar_tutorial_provider.dart';
import 'package:proyecto_tesina/presentation/screens/dui/dui_info_screen.dart';
import 'package:proyecto_tesina/presentation/screens/graficos/graficos.dart';
import 'package:proyecto_tesina/presentation/screens/screens.dart';


final appRouterProvider = Provider<GoRouter>((ref) {
  final tutorialMostrado = ref.watch(mostrarTutorialProvider);
  ref.read(isDarkModeProvider.notifier).initialModeStatus();
  return GoRouter(
  initialLocation: tutorialMostrado ? '/' : '/tutorial',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/dui',
      name: DuiScreen.name,
      builder: (context, state) => const DuiScreen(),
    ),
    GoRoute(
      path: '/graficos',
      name: Graficos.name,
      builder: (context, state) => Graficos(),
    ),
    GoRoute(
      path: '/tutorial',
      name: Tutorial.name,
      builder: (context, state) => const Tutorial(),
    ),
    GoRoute(
      path: '/info',
      name: DuiInfoScreen.name,
      builder: (context, state) => const DuiInfoScreen(),
    ),
  ]);
});