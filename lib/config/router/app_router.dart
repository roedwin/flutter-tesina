import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_tesina/presentation/screens/dui/dui_info_screen.dart';
import 'package:proyecto_tesina/presentation/screens/graficos/graficos.dart';
import 'package:proyecto_tesina/presentation/screens/screens.dart';


final appRouter = GoRouter(
  initialLocation: '/',
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
      path: '/info',
      name: DuiInfoScreen.name,
      builder: (context, state) => const DuiInfoScreen(),
    ),
    GoRoute(
      path: '/graficos',
      name: Graficos.name,
      builder: (context, state) => Graficos(),
    ),
  ]
);