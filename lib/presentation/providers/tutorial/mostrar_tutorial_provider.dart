import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final mostrarTutorialProvider =
    StateNotifierProvider<MostrarTutorialNotifier, bool>((ref) {
  return MostrarTutorialNotifier();
});

class MostrarTutorialNotifier extends StateNotifier<bool> {
  MostrarTutorialNotifier() : super(false){checkInitialStatus();}

  void checkInitialStatus() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool tutorialShown = prefs.getBool('tutorialShown') ?? false;
    state = tutorialShown;
  }

  void checkTutorialStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool('tutorialShown') ?? false;

    if (!state) {
      
      state = true;
      // Marcar el tutorial como mostrado para futuras sesiones
      prefs.setBool('tutorialShown', true);
    }
  }
}
