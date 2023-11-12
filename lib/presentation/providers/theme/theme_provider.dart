import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tesina/config/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void isDark() async{   
    state = !state;
    checkDarkModeStatus();
  }
  void checkDarkModeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool('isDarkMode') ?? false;
    prefs.setBool('isDarkMode', state);
  }

  void initialModeStatus() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool statusMode = prefs.getBool('isDarkMode') ?? false;
    state = statusMode;

  }
    
}