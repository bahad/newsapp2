import 'package:flutter/material.dart';
import '../core/init/theme/color_manager.dart';
import 'custom_text.dart';

class AnimatedCustomButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String? label;
  const AnimatedCustomButton(
      {Key? key, required this.onPressed, required this.label})
      : super(key: key);

  @override
  State<AnimatedCustomButton> createState() => _AnimatedCustomButtonState();
}

class _AnimatedCustomButtonState extends State<AnimatedCustomButton> {
  bool _clicked = false;
  double _opacity = 1.0;
  bool _visible = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: InkWell(
        onTap: _clicked
            ? null
            : () {
                setState(() {
                  _clicked = !_clicked;
                  _opacity = _opacity == 1.0 ? 0.0 : 1.0;
                  Future.delayed(const Duration(milliseconds: 800), () {
                    setState(() {
                      _visible = !_visible;
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        setState(() {
                          _visible = !_visible;
                          _clicked = !_clicked;
                          _opacity = _opacity == 1.0 ? 0.0 : 1.0;
                        });
                      });
                    });
                  });
                });
              },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 700),
          curve: Curves.fastOutSlowIn,
          width: _clicked ? size.width * 0.17 : size.width,
          height: size.height * 0.058,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_clicked ? 60 : 10),
              color: ColorManager.instance.buttonColor),
          child: Center(
              child: !_visible
                  ? AnimatedOpacity(
                      opacity: _opacity,
                      duration: const Duration(seconds: 1),
                      child: CustomText(
                        text: widget.label,
                        sizes: Sizes.normal,
                        textAlign: TextAlign.center,
                        color: Colors.white,
                      ))
                  : const CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    )),
        ),
      ),
    );
  }
}
