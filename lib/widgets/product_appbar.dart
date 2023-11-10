import 'package:entekaravendor/constants/constants.dart';
import 'package:flutter/material.dart';

Widget productAppbar(String title, context) {
  return AppBar(
    elevation: 0,
    shadowColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    automaticallyImplyLeading: false,
    leading: InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(Icons.arrow_back_ios_new_outlined),
    ),
    centerTitle: true,
    title: Text(
      "$title",
      style: appbarTextStyle,
      textScaleFactor: textFactor,
    ),
    actions: [Image.asset("assets/images/filter.png")],
  );
}
