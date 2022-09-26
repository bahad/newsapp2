import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  const CustomIcon({Key? key, this.icon, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Icon(icon,
        color: color,
        size: size.width < 390
            ? 20
            : size.width > 500
                ? 32
                : 24);
  }
}
