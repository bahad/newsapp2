// ignore_for_file: prefer_conditional_assignment, non_constant_identifier_names, unnecessary_null_comparison

import 'package:flutter/material.dart';

class ColorManager {
  static final ColorManager _instace = ColorManager._init();
  static ColorManager get instance {
    return _instace;
  }

  ColorManager._init();

  Color get white => const Color(0xffffffff);
  Color get iconColor => const Color(0xFF609bf0);
  Color get buttonColor => const Color(0xFF317fea);
  Color get success => const Color(0xFFa8ff78);
  Color get warning => const Color(0xFFf3f9a7);
  Color get fail => const Color(0xFFec2F4B);
  Color get secondaryIconColor => const Color(0xFFC33764);
  Color get disabledColor => const Color(0xFF25383C);

  MaterialColor get materialGray => const MaterialColor(
        0xffffffff,
        <int, Color>{
          50: Colors.white,
          100: Colors.white,
          200: Colors.white,
          300: Colors.white,
          400: Colors.white,
          500: Colors.white,
          600: Colors.white,
          700: Colors.white,
          800: Colors.white,
          900: Colors.white,
        },
      );
}
