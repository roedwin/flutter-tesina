import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.subTitle, 
    required this.link, 
    required this.icon
  });  
}

const appMenuItems = <MenuItem>[
  MenuItem(
    title: 'Home screen', 
    subTitle: 'Home', 
    link: '/', 
    icon: Icons.home
  ),
  MenuItem(
    title: 'Verificar Dui', 
    subTitle: 'Introducir dui para obtener datos', 
    link: '/dui', 
    icon: Icons.credit_card
  ),
  MenuItem(
    title: 'Graficos', 
    subTitle: 'Varios tipos de graficos', 
    link: '/graficos', 
    icon: Icons.auto_graph_outlined
  ),
  MenuItem(
    title: 'Tutorial', 
    subTitle: 'Como ejercer el voto', 
    link: '/tutorial', 
    icon: Icons.accessible_rounded
  ),
  MenuItem(
    title: 'Informacion', 
    subTitle: 'Muestra la informacion del votante', 
    link: '/info', 
    icon: Icons.info
  ),
  
];