import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsapp2/components/custom_text.dart';
import 'package:newsapp2/core/base/base_state.dart';

class EmptyPage extends StatelessWidget {
  final String? text;
  const EmptyPage({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/empty_list.svg',
            height: Utility.dynamicWidthPixel(200),
          ),
          Padding(
            padding: EdgeInsets.all(Utility.dynamicWidthPixel(40)),
            child: CustomText(
              text: text,
              sizes: Sizes.normal,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
