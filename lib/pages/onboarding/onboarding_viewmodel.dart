import 'package:flutter/material.dart';
import 'package:newsapp2/pages/onboarding/widgets/splash_item.dart';

class OnBoardingProvider extends ChangeNotifier {
  PageController? pageController;
  int selectedIndex = 0;

  changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  OnBoardingProvider() {
    pageController = PageController(viewportFraction: 1);
  }

  List<OnBoardingItem> splashItems = [
    const OnBoardingItem(
      imageUrl: 'assets/images/splash_1.jpg',
      title: 'Gündemden Haberdar Ol',
      subTitle:
          'Tabletinden veya telefonunda dilediğin yerde en güncel haberlere ulaşabilirsin.',
    ),
    const OnBoardingItem(
      imageUrl: 'assets/images/splash_2.jpg',
      title: 'Beğen veya Paylaş',
      subTitle:
          'Beğendiğin haberleri favori listene ekleyip daha sonra okuyabilir veya dilersen arkadaşlarınla paylaşabilirsin.',
    ),
    const OnBoardingItem(
      imageUrl: 'assets/images/splash_3.jpg',
      title: 'Haber Oluştur',
      subTitle:
          'Dahası da var. Uygulamaya üye olup seviye atlayarak kendi haberini oluşturarak yazarlığa adımını atabilirsin.',
    )
  ];
}
