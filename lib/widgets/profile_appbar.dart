import 'package:entekaravendor/constants/constants.dart';
import 'package:flutter/material.dart';

Widget profileAppbar(String title) {
  return AppBar(
    elevation: 0,
    shadowColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    automaticallyImplyLeading: false,
    centerTitle: true,
    title: Text(
      "$title",
      style: appbarTextStyle,
      textScaleFactor: textFactor,
    ),
  );
}
