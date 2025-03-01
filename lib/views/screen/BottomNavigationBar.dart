// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../core/color_manager.dart';
import '../widget/qiblah_details/view.dart';
import 'home/home.dart';
import 'Settings/Settings_Screen.dart';
import 'search/Search_Screen.dart';

class NavBarView extends StatefulWidget {
  const NavBarView({
    super.key,
  });

  @override
  State<NavBarView> createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> {
  int currentIndex = 3;
  List screens = const [
    SettingsScreen(),
    QiblahDetails(),
    SearchScreen(),
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomNavigationBar(
          unselectedItemColor: ColorManager.blueColor,
          selectedItemColor: ColorManager.goldenColor,
          items: const [
            BottomNavigationBarItem(
              tooltip: 'الإعدادات',
              icon: Icon(
                Icons.settings,
                size: 25,
              ),
              label: 'الإعدادات',
            ),
            BottomNavigationBarItem(
              tooltip: 'القبلة',
              icon: Icon(
                Icons.mosque,
                size: 25,
              ),
              label: 'القبلة',
            ),
            BottomNavigationBarItem(
              tooltip: 'البحث',
              icon: Icon(
                Icons.search,
                size: 25,
              ),
              label: 'البحث',
            ),
            BottomNavigationBarItem(
              tooltip: 'الرئيسية',
              icon: Icon(
                Icons.home,
                size: 25,
              ),
              label: 'الرئيسية',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          elevation: 10.0,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
