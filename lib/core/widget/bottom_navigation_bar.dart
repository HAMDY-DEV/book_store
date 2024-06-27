import 'package:book_store/core/util/colors.dart';
import 'package:book_store/features/favorite/presenntation/view/favorite_view.dart';
import 'package:book_store/features/home/presentation/view/homw_view.dart';
import 'package:book_store/features/profile/presentation/view/profile_view.dart';
import 'package:book_store/features/show_book_detels/presentation/view/product_view.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  List<Widget> list = [
    const HomeView(),
    ProductView(),
    const FavoriteView(),
    const ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[selectedIndex],
      bottomNavigationBar: WaterDropNavBar(
        backgroundColor: Colors.white,
        onItemSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        selectedIndex: selectedIndex,
        barItems: [
          BarItem(
            filledIcon: Icons.home_rounded,
            outlinedIcon: Icons.home_outlined,
          ),
          BarItem(
            filledIcon: Icons.book_rounded,
            outlinedIcon: Icons.book_outlined,
          ),
          BarItem(
              filledIcon: Icons.favorite_rounded,
              outlinedIcon: Icons.favorite_border_rounded),
          BarItem(
              filledIcon: Icons.person_rounded,
              outlinedIcon: Icons.person_outline_rounded),
        ],
        waterDropColor: AppColors.primaryColor,
      ),
    );
  }
}
//Pearson
