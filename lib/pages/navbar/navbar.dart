import 'package:flutter/material.dart';
import 'package:newsapp2/pages/favorites/favorites_view.dart';

import 'package:newsapp2/pages/home/home_view.dart';

import '../../core/init/cache/shared_preferences_config.dart';
import '../profile/profile_view.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({Key? key}) : super(key: key);

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  int? index = 0;
  final screens = [
    const HomePage(),
    const FavoritesPage(),
    const ProfilePage()
  ];

  @override
  void initState() {
    PreferenceUtils.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /* appBar: PreferredSize(
          preferredSize: Size.fromHeight(46),
          child: AppBar(
            title: CustomText(
              text: 'Başlıklar',
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            actions: [],
          ),
        ), */
        bottomNavigationBar: NavigationBar(
          //backgroundColor: Colors.green[90],
          height: 60,
          selectedIndex: index!,
          animationDuration: const Duration(seconds: 3),
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_outlined), label: 'Başlıklar'),
            NavigationDestination(
                icon: Icon(Icons.bookmark_outline), label: 'Listem'),
            NavigationDestination(
                icon: Icon(Icons.person_outline_outlined), label: 'Profil'),
          ],
        ),
        body: WillPopScope(
            child: SafeArea(
                top: index == 0 ? true : false, child: screens[index!]),
            onWillPop: () async => false));
  }
}
