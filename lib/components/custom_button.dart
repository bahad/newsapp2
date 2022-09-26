import 'package:flutter/material.dart';

import '../core/init/theme/color_manager.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String? label;
  final VoidCallback? onPressed;
  final double? topPadding;

  const CustomButton({Key? key, this.label, this.onPressed, this.topPadding})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: topPadding!),
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          width: double.infinity,
          height: size.height * 0.06,
        ),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(ColorManager.instance.buttonColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)))),
          onPressed: onPressed,
          child: CustomText(
            color: ColorManager.instance.white,
            sizes: Sizes.normal,
            text: label!,
          ),
        ),
      ),
    );
  }
}
