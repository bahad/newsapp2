import 'package:flutter/material.dart';

import 'package:newsapp2/core/base/base_state.dart';
import 'package:newsapp2/core/init/theme/color_manager.dart';

class SplashIndicator extends StatelessWidget {
  final bool isActive;
  const SplashIndicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInCirc,
      width: isActive
          ? Utility.dynamicWidthPixel(65)
          : Utility.dynamicWidthPixel(22),
      height: Utility.dynamicWidthPixel(8),
      margin: EdgeInsets.symmetric(horizontal: Utility.dynamicWidthPixel(4)),
      decoration: BoxDecoration(
          color: isActive ? ColorManager.instance.buttonColor : Colors.grey,
          borderRadius: BorderRadius.circular(8)),
    );
  }
}
