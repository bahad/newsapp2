import 'package:flutter/material.dart';

enum Sizes {
  xsmall,
  small,
  normal,
  big,
  title,
  sliverTitle,
}

class CustomText extends StatelessWidget {
  final Sizes? sizes;
  final String? text;
  final Color? color;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final int? maxLines;
  // ignore: use_key_in_widget_constructors
  const CustomText({
    this.text,
    this.color,
    this.sizes,
    this.textAlign,
    this.fontWeight,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Text(text!,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
        maxLines: maxLines ?? 3,
        style: sizes == Sizes.normal
            ? TextStyle(
                color: color,
                fontWeight: fontWeight ?? FontWeight.w500,
                fontFamily: 'satoshi-regular',
                fontSize: size.width < 390
                    ? 16
                    : size.width > 500
                        ? 24
                        : 18)
            : sizes == Sizes.title
                ? TextStyle(
                    color: color,
                    fontWeight: fontWeight,
                    fontFamily: 'satoshi-bold',
                    fontSize: size.width < 390
                        ? 18
                        : size.width > 500
                            ? 26
                            : 20)
                : sizes == Sizes.small
                    ? TextStyle(
                        color: color,
                        fontWeight: fontWeight,
                        fontSize: size.width < 390
                            ? 14
                            : size.width > 500
                                ? 22
                                : 16)
                    : sizes == Sizes.xsmall
                        ? TextStyle(
                            color: color,
                            fontWeight: fontWeight,
                            fontFamily: 'satoshi-regular',
                            fontSize: size.width < 390
                                ? 12
                                : size.width > 500
                                    ? 20
                                    : 14)
                        : sizes == Sizes.sliverTitle
                            ? TextStyle(
                                color: color,
                                fontWeight: fontWeight,
                                fontFamily: 'nunito-semibold',
                                fontSize: size.width < 390
                                    ? 24
                                    : size.width > 500
                                        ? 34
                                        : 28)
                            : TextStyle(
                                color: color,
                                fontWeight: fontWeight,
                                fontFamily: 'satoshi-medium',
                                fontSize: size.width < 390
                                    ? 18
                                    : size.width > 500
                                        ? 26
                                        : 20));
  }
}
