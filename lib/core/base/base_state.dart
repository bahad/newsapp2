import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  double dynamicTextSize(double fontSize) {
    if (MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .size
            .shortestSide >
        600) {
      return fontSize.sp * 0.55;
    } else {
      return fontSize.sp * 0.88;
    }
  }

  double dynamicHeightPixel(double size) => size.h;
  double dynamicWidthPixel(double size) => size.w * 0.88;

  DeviceType getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? DeviceType.phone : DeviceType.tablet;
  }

  isTablet() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? false : true;
  }
}

class Utility {
  static double dynamicTextSize(double fontSize) {
    if (MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .size
            .shortestSide >
        600) {
      return fontSize.sp * 0.55;
    } else {
      return fontSize.sp * 0.88;
    }
  }

  static double dynamicHeight(double size) =>
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height *
      size;
  static double dynamicWidth(double size) =>
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width *
      size;

  static double dynamicHeightPixel(double size) => size.h;
  static double dynamicWidthPixel(double size) {
    if (MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .size
            .shortestSide >
        600) {
      return size.w * 0.55;
    } else {
      return size.w * 0.88;
    }
  }

  DeviceType getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? DeviceType.phone : DeviceType.tablet;
  }

  isTablet() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? false : true;
  }
}

enum DeviceType { phone, tablet }
