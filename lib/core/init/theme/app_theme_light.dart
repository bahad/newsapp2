import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'color_manager.dart';

class AppThemeLight extends AppTheme {
  static AppThemeLight? _instance;
  static AppThemeLight get instance {
    _instance ??= AppThemeLight._init();
    return _instance!;
  }

  AppThemeLight._init();
  @override
  ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: ColorManager.instance.white,
        // highlightColor: ColorManager.instance.transparent,
        // focusColor: ColorManager.instance.transparent,
        // hoverColor: ColorManager.instance.transparent,
        // splashColor: ColorManager.instance.transparent,
        // shadowColor: ColorManager.instance.transparent,
        backgroundColor: ColorManager.instance.buttonColor,
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
