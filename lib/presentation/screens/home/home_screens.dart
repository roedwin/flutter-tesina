import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/menu/menu_items.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FilledButton(
            onPressed: () {
              final menuItem = appMenuItems[1];
              context.push(menuItem.link);
            }, 
            child: const Text("Verificar centro de votacion")
          ),
          FilledButton(
            onPressed: () {
              final menuItem = appMenuItems[3];
              context.push(menuItem.link);
            }, 
            child: const Text("Graficos")
          ),
        ]
        
      ),
    );
  }
}