import 'package:flutter/material.dart';
import 'package:newsapp2/core/init/cache/shared_preferences_config.dart';

import 'color_manager.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  get themeMode => _themeMode;

  toggleTheme(bool isDark) {
    PreferenceUtils.init();
    if (isDark) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    // PreferenceUtils.setString("theme", "");

    notifyListeners();
  }
}

class MyTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorManager.instance.white,
    backgroundColor: ColorManager.instance.buttonColor,
    brightness: Brightness.light,
    useMaterial3: true,
    fontFamily: "satoshi-regular",
    //  primarySwatch: ColorManager.instance.materialGray,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorManager.instance.white,
    backgroundColor: ColorManager.instance.buttonColor,
    brightness: Brightness.dark,
    useMaterial3: true,
    fontFamily: "satoshi-regular",
    //  primarySwatch: ColorManager.instance.materialGray,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
