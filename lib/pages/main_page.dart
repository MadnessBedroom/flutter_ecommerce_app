import 'package:animations/animations.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/common/data.dart';
import 'package:flutter_ecommerce_app/controllers/controller.dart';
import 'package:flutter_ecommerce_app/pages/cart_page.dart';
import 'package:flutter_ecommerce_app/pages/favorite_page.dart';
import 'package:flutter_ecommerce_app/pages/home_page.dart';
import 'package:flutter_ecommerce_app/pages/profile_page.dart';
import 'package:get/get.dart';

class MainPage extends GetView<AppController> {
  const MainPage({super.key});
  static const List<Widget> _screens = [
    HomePage(),
    FavoredPage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: PageTransitionSwitcher(
          duration: const Duration(seconds: 1),
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: _screens[controller.state.currentBottomNavItemIndex.value],
        ),
        bottomNavigationBar: BottomNavyBar(
          showElevation: false,
          itemCornerRadius: 10,
          selectedIndex: controller.state.currentBottomNavItemIndex.value,
          items: AppData.bottomNavyBarItems
              .map((e) => BottomNavyBarItem(
                  icon: e.icon,
                  title: e.title,
                  activeColor: e.activeColor,
                  inactiveColor: e.inactiveColor))
              .toList(),
          onItemSelected: controller.switchBetweenBottomNavigationItems,
        ),
      ),
    );
  }
}
