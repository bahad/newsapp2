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
  Color get warning => const Color(0xFFE6A03A);
  Color get secondaryIconColor => const Color(0xFFC33764);
  Color get disabledColor => const Color(0xFF25383C);
  Color get success => const Color(0xFF052100);
  Color get successText => const Color(0xFFB6F397);
  Color get fail => const Color(0xFF400F0C);
  Color get failText => const Color(0xFFF9DEDC);
  Color get infoContainer => const Color(0xFFE6E4BF);
}
