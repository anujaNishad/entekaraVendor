import 'package:flutter/material.dart';

Widget backAppbar(context) {
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
  );
}
