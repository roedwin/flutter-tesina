import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tesina/config/theme/app_theme.dart';

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, Apptheme>(
  (ref) {
    final isDark = ref.watch(isDarkModeProvider);
    return ThemeNotifier(isDark: isDark);
  }
);


class ThemeNotifier extends StateNotifier<Apptheme> {
  final bool isDark;
  ThemeNotifier({required this.isDark}): super(Apptheme());
  
  void toggleDarkmode(){
    state = state.copyWith(isDarkmode: isDark);
  }
  
}

final isDarkModeProvider = StateNotifierProvider<IsDark,bool>((ref) {
  return IsDark();
});

class IsDark extends StateNotifier<bool>{
  IsDark(): super(false);

  void isDark(){
    state = !state;
  }
}