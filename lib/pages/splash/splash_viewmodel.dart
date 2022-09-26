import 'package:flutter/material.dart';
import 'package:newsapp2/pages/splash/widgets/splash_item.dart';

class SplashProvider extends ChangeNotifier {
  PageController? pageController;
  int selectedIndex = 0;

  changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  SplashProvider() {
    pageController = PageController(viewportFraction: 1);
  }

  List<SplashItem> splashItems = [
    const SplashItem(
      imageUrl: 'assets/images/splash_1.jpg',
      title: 'Gündemden Haberdar Ol',
      subTitle:
          'Tabletinden veya telefonunda dilediğin yerde en güncel haberlere ulaşabilirsin.',
    ),
    const SplashItem(
      imageUrl: 'assets/images/splash_2.jpg',
      title: 'Beğen veya Paylaş',
      subTitle:
          'Beğendiğin haberleri favori listene ekleyip daha sonra okuyabilir veya dilersen arkadaşlarınla paylaşabilirsin.',
    ),
    const SplashItem(
      imageUrl: 'assets/images/splash_3.jpg',
      title: 'Haber Oluştur',
      subTitle:
          'Dahası da var. Uygulamaya üye olup seviye atlayarak kendi haberini oluşturarak yazarlığa adımını atabilirsin.',
    )
  ];
}
