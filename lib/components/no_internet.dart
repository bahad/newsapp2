import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsapp2/components/custom_button.dart';
import 'package:newsapp2/components/custom_text.dart';
import 'package:newsapp2/core/base/base_state.dart';

class NoInternet extends StatelessWidget {
  final Function? onTap;
  const NoInternet({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Utility.dynamicWidthPixel(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/404.svg',
              height: size.height * 0.17,
            ),
            SizedBox(height: Utility.dynamicWidthPixel(38)),
            const CustomText(
              sizes: Sizes.normal,
              text:
                  'Sayfaya erişemiyoruz. Lütfen internet bağlantınızı kontrol edip tekrar deneyin.',
              textAlign: TextAlign.center,
            ),
            CustomButton(
              topPadding: Utility.dynamicWidthPixel(38),
              label: 'Tekrar Dene',
              buttonColor: Colors.indigo,
              onPressed: () {
                onTap!();
              },
            )
          ],
        ),
      ),
    );
  }
}
