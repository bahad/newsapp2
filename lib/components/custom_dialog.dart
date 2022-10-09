import 'package:flutter/cupertino.dart';
import 'package:newsapp2/components/custom_text.dart';
import 'package:newsapp2/core/base/base_state.dart';
import 'package:newsapp2/core/init/theme/color_manager.dart';

class CustomDialog {
  showDialog(
    Widget title,
    String? text,
    Function? onConfirm,
    context,
  ) {
    return showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: ((context1) => CupertinoAlertDialog(
              title: title,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Utility.dynamicWidthPixel(30)),
                  CustomText(
                    sizes: Sizes.normal,
                    text: text.toString(),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Utility.dynamicWidthPixel(18)),
                ],
              ),
              actions: [
                CupertinoDialogAction(
                  textStyle: TextStyle(color: ColorManager.instance.fail),
                  child: const CustomText(
                    sizes: Sizes.normal,
                    text: 'İptal',
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    //   Navigator.of(context1).pop();
                  },
                ),
                CupertinoDialogAction(
                    onPressed: () {
                      onConfirm!();
                    },
                    child: const CustomText(
                      sizes: Sizes.normal,
                      text: 'Onayla',
                      textAlign: TextAlign.center,
                    )),
              ],
            )));
  }
}
