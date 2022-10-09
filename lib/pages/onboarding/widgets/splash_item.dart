import 'package:flutter/material.dart';

import 'package:newsapp2/components/custom_text.dart';
import 'package:newsapp2/core/base/base_state.dart';

class OnBoardingItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subTitle;
  const OnBoardingItem(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * 0.396, //370,
          margin:
              EdgeInsets.symmetric(horizontal: Utility.dynamicWidthPixel(16)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(imageUrl),
              )),
        ),
        SizedBox(height: Utility.dynamicWidthPixel(50)),
        CustomText(
          sizes: Sizes.big,
          fontWeight: FontWeight.w600,
          text: title,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: EdgeInsets.all(Utility.dynamicWidthPixel(24)),
          child: CustomText(
            sizes: Sizes.normal,
            fontWeight: FontWeight.w500,
            text: subTitle,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
