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
    subTitle: 'Introduccion a riverpod', 
    link: '/', 
    icon: Icons.countertops_outlined
  ),
  MenuItem(
    title: 'Verificar Dui', 
    subTitle: 'Introduccion a riverpod', 
    link: '/dui', 
    icon: Icons.countertops_outlined
  ),
  MenuItem(
    title: 'Informacion', 
    subTitle: 'Varios bonotes en flutter', 
    link: '/info', 
    icon: Icons.smart_button_outlined
  ),
  
];