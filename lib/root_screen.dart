import 'package:e_store/core/constants/app_colors.dart';
import 'package:e_store/features/cart/view/cart_screen.dart';
import 'package:e_store/features/settings/view/settings_screen.dart';
import 'package:e_store/features/shop/view/home_screen.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  List pages = [HomeScreen(), CartScreen(), SettingsScreen()];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });
        },
        selectedItemColor: AppColors.greenAccent,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),

        ],
      )

    );
  }
}
