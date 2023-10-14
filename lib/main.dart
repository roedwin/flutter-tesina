import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tesina/config/router/app_router.dart';
import 'package:proyecto_tesina/config/theme/app_theme.dart';
//import 'package:proyecto_tesina/presentation/screens/screens.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp()
    )
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp.router(
        title: 'TSE',
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        theme: Apptheme().getTheme(),
      );
  }
}
