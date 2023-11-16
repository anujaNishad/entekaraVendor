import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/Dashboard/view/dashboard.dart';
import 'package:entekaravendor/pages/product/view/product_details.dart';
import 'package:entekaravendor/pages/profile/view/profile_screen.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  Color iconColor = Colors.black;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: getProportionateScreenHeight(90),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2.0,
              ),
            ],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: getProportionateScreenHeight(50),
            items: <Widget>[
              getBottomBarItemTile(0, Icons.home_outlined),
              getBottomBarItemTile(1, Icons.shop),
              getBottomBarItemTile(2, Icons.account_circle),
            ],
            color: Colors.white,
            buttonBackgroundColor: backgroundColor,
            backgroundColor: Colors.white,
            //animationCurve: Curves.slowMiddle,
            //animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                _page = index;
                iconColor = primaryColor;
              });
            },
            letIndexChange: (index) => true,
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            exit(0);
          }
          return false;
        },
        child: IndexedStack(
          index: _page,
          children: [
            const DashboardDetails(),
            const ProductDetails(
              isBack: false,
            ),
            const ProfileScreen(),
          ],
        ),
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }

  getBottomBarItemTile(int index, icon) {
    return Icon(icon,
        size: getProportionateScreenHeight(30),
        color: (_page == index) ? primaryColor : Colors.black);
  }
}
