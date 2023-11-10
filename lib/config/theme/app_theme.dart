import 'package:flutter/material.dart';

class Apptheme {
  final bool isDarkmode;

  Apptheme({this.isDarkmode = false});

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    brightness: isDarkmode ? Brightness.dark : Brightness.light,
    colorSchemeSeed: const Color(0xff2862f5) 
  );
  Apptheme copyWith({
    bool? isDarkmode
  }) => Apptheme(
    isDarkmode: isDarkmode ?? this.isDarkmode,
  );
}