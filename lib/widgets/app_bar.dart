import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final langs = {
  'English': 'en',
  'Hindi': 'hi',
  'Bengali': 'bn',
  'Telugu': 'te',
  'Marathi': 'mr',
  'Tamil': 'ta',
  'Urdu': 'ur',
  'Gujarati': 'gu',
  'Malayalam': 'ml',
  'Kannada': 'kn',
  'Oriya': 'or',
  'Punjabi': 'pa',
  'Assamese': 'as',
  'Maithili': 'mai',
  'Santali': 'sat',
  'Kashmiri': 'ks',
  'Nepali': 'ne',
  'Konkani': 'kok',
  'Sindhi': 'sd',
  'Dogri': 'doi',
  'Manipuri': 'mni',
};

class AppBarState {
  final bool isLightMode;
  final String selectedLang;
  final String langCode;

  AppBarState({
    this.isLightMode = true,
    this.selectedLang = 'English',
    this.langCode = 'en',
  });
}

class CustomAppBar extends ConsumerStatefulWidget {
  const CustomAppBar({super.key});

  @override
  ConsumerState<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends ConsumerState<CustomAppBar> {
  String code = 'en';
  void getCode(String lang, String langCode) {
    setState(() {
      code = langCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBarNotifier = ref.watch(settingsProvider.notifier);
    final appBarState = ref.watch(settingsProvider);
    final theme = ref.watch(settingsProvider);
    return Container(
      color: Theme.of(context).primaryColor,
      height: 100,
      margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              appBarNotifier.isLightMode = !appBarNotifier.isLightMode;
              appBarNotifier.savePreferences();
            },
            child: GeneralAppIcon(
              icon: appBarState.isLightMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
              color: theme.isLightMode == true ? textColor1 : textColor2,
            ),
          ),
          Row(
            children: [
              GeneralAppIcon(
                icon: Icons.language_outlined,
                color: theme.isLightMode == true ? textColor1 : textColor2,
              ),
              const SizedBox(
                width: 10,
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(10),
                  menuMaxHeight: 400,
                  onChanged: (String? value) {
                    setState(() {
                      appBarNotifier.selectedLang = value!;
                      appBarNotifier.savePreferences();
                    });
                  },
                  value: appBarState.selectedLang,
                  items: langs.keys.map<DropdownMenuItem<String>>(
                    (e) {
                      return DropdownMenuItem(
                        value: e,
                        child: DropdownText(
                          text: e,
                          size: 20,
                          weight: FontWeight.bold,
                          color: theme.isLightMode == true
                              ? textColor1
                              : textColor2,
                        ),
                        onTap: () {
                          getCode(e, langs[e]!);
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
