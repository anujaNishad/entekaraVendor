import 'dart:async';
import 'dart:io';

import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/model/status_model.dart';
import 'package:entekaravendor/pages/Dashboard/view/home_screen.dart';
import 'package:entekaravendor/pages/location_details/view/location_details.dart';
import 'package:entekaravendor/pages/splash_screen/data/splash_api.dart';
import 'package:entekaravendor/pages/vendor_login/vendor_loading/view/vendor_loading.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DateTime? currentBackPressTime;
  final storage = GetStorage();
  final SplashApi _splashApi = SplashApi();
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => storage.read("token") != "" && storage.read("token") != null
            ? getData()
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const VendorLoadingScreen()),
              ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool backStatus = onWillPop();
        if (backStatus) {
          exit(0);
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/logo.png',
                height: getProportionateScreenHeight(100),
                width: getProportionateScreenWidth(110),
              ),
            ),
            heightSpace10,
            Align(
              alignment: Alignment.center,
              child: Text(
                "Entekara",
                style: heading18PrimaryTextStyle,
                textScaleFactor: geTextScale(),
              ),
            ),
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

  void getData() async {
    try {
      final response = await _splashApi.getStatus(storage.read("mobile"));
      if (response["message"] == "Success") {
        StatusModel? statusModel = StatusModel.fromJson(response);
        if (statusModel.data!.existing == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LocationDetails(
                      phoneNumber: storage.read("mobile"),
                      userId: storage.read("vendorId"),
                    )),
          );
        } else if (statusModel.data!.existing == 1 &&
            statusModel.data!.isApproved == "yes") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      } else if (response["message"] != "Success") {
        Fluttertoast.showToast(msg: response["message"]);
      } else {
        Fluttertoast.showToast(msg: response["errmessage"]);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
