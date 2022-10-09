import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp2/components/custom_text.dart';

import '../../../core/base/base_state.dart';

class ProfileListItem extends StatelessWidget {
  final String? image, title, subtitle;
  final Widget? trailing;
  final Function? onTap;
  const ProfileListItem(
      {super.key,
      this.image,
      this.title,
      this.subtitle,
      this.trailing,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        image!,
        height: Utility.dynamicWidthPixel(31),
      ),
      title: CustomText(
        text: title,
        sizes: Sizes.normal,
        fontWeight: FontWeight.bold,
      ),
      /*  subtitle: CustomText(
        sizes: Sizes.small,
        text: subtitle,
      ), */
      trailing: trailing,
      onTap: () {
        onTap!();
      },
    );
  }
}
