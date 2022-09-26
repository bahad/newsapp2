// ignore_for_file: unused_local_variable, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newsapp2/components/custom_text.dart';
import 'package:newsapp2/core/base/base_state.dart';
import 'package:newsapp2/core/init/theme/color_manager.dart';
import 'package:newsapp2/pages/navbar/navbar.dart';
import 'package:newsapp2/pages/splash/splash_viewmodel.dart';
import 'package:newsapp2/pages/splash/widgets/splash_indicator.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    SplashProvider vm = Provider.of<SplashProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SplashProvider vm = Provider.of<SplashProvider>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: Utility.dynamicWidthPixel(100)),
        child: Stack(
          // fit: StackFit.expand,
          children: [
            Container(
              height: size.height * 0.718, //670,
              width: size.width,
              margin: EdgeInsets.all(Utility.dynamicWidthPixel(16)),
              child: PageView.builder(
                  onPageChanged: (index) {
                    vm.changeIndex(index);
                  },
                  controller: vm.pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: vm.splashItems.length,
                  itemBuilder: ((context, index) {
                    var _scale = vm.selectedIndex == index ? 1.0 : 0.0;
                    return TweenAnimationBuilder(
                      curve: Curves.easeOut,
                      tween: Tween(begin: _scale, end: _scale),
                      duration: const Duration(milliseconds: 500),
                      builder: ((context, value, child) => Transform.scale(
                            scale: value,
                            child: child,
                          )),
                      child: vm.splashItems[index],
                    );
                  })),
            ),
            Positioned(
              bottom: Utility.dynamicWidthPixel(12),
              left: Utility.dynamicWidthPixel(12),
              child: SizedBox(
                width: size.width,
                child: Padding(
                  padding: EdgeInsets.all(Utility.dynamicWidthPixel(24)),
                  child: Row(
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            ...List.generate(
                                vm.splashItems.length,
                                (index) => SplashIndicator(
                                      isActive: vm.selectedIndex == index
                                          ? true
                                          : false,
                                    )),
                          ],
                        ),
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  ColorManager.instance.buttonColor,
                              foregroundColor: Colors.white),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const NavbarPage())));
                          },
                          icon: Lottie.asset('assets/images/arrow_right.json',
                              filterQuality: FilterQuality.high,
                              height: Utility.dynamicWidthPixel(60)),
                          label: const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: CustomText(
                              color: Colors.white,
                              sizes: Sizes.normal,
                              fontWeight: FontWeight.w600,
                              text: 'Atla',
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
