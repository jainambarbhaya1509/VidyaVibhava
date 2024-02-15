import 'package:final_project/widgets/app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final settingsProvider =
    StateNotifierProvider<AppBarNotifier, AppBarState>((ref) {
  return AppBarNotifier();
});

class AppBarNotifier extends StateNotifier<AppBarState> {
  AppBarNotifier() : super(AppBarState()) {
    loadPreferences();
  }

  set isLightMode(bool value) {
    state = AppBarState(
        isLightMode: value,
        selectedLang: state.selectedLang,
        langCode: state.langCode);
    savePreferences();
  }

  bool get isLightMode => state.isLightMode;

  set selectedLang(String value) {
    final String langCode = langs[value]!;
    state = AppBarState(
        isLightMode: state.isLightMode,
        selectedLang: value,
        langCode: langCode);

    savePreferences();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    state = AppBarState(
        isLightMode: prefs.getBool('isLightMode') ?? state.isLightMode,
        selectedLang: prefs.getString('selectedLang') ?? state.selectedLang,
        langCode: prefs.getString('langCode') ?? state.langCode);
  }

  Future<void> savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLang', state.selectedLang);
    await prefs.setBool('isLightMode', state.isLightMode);
    await prefs.setString('langCode', state.langCode);
  }
}
