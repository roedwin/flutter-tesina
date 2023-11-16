import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tesina/config/router/app_router.dart';
import 'package:proyecto_tesina/presentation/providers/theme/theme_provider.dart';
//import 'package:proyecto_tesina/presentation/screens/screens.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isDarkmode = ref.watch(isDarkModeProvider);
    final appRouter = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'TSE',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          brightness: isDarkmode ? Brightness.dark : Brightness.light,
          colorSchemeSeed: const Color(0xff2862f5)),
    );
  }
}
