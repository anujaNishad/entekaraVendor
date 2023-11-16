import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/edit_profile/view/edit_profile.dart';
import 'package:entekaravendor/pages/manage_time/view/manage_time.dart';
import 'package:entekaravendor/pages/vendor_login/vendor_loading/view/vendor_loading.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:entekaravendor/widgets/profile_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final storage = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(getProportionateScreenHeight(50)),
          child: profileAppbar("Profile")),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 8,
                child: Column(
                  children: [
                    heightSpace10,
                    Center(
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage:
                            NetworkImage("${storage.read("thumbnail")}"),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    heightSpace10,
                    Center(
                      child: Column(
                        children: [
                          Text(
                            '${storage.read("vendorName")}',
                            style: heading18TextStyle,
                            textScaleFactor: geTextScale(),
                          ),
                          Text(
                            '${storage.read("mobile")}',
                            style: Text10STextStyle,
                            textScaleFactor: geTextScale(),
                          )
                        ],
                      ),
                    ),
                    heightSpace10,
                    Divider(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()),
                        );
                      },
                      child: Container(
                        child: Column(
                          children: [
                            heightSpace10,
                            Row(
                              children: [
                                widthSpace20,
                                Icon(Icons.edit_outlined),
                                widthSpace10,
                                Text(
                                  "Edit Profile",
                                  style: OTPHeading14TextStyle,
                                  textScaleFactor: geTextScale(),
                                ),
                              ],
                            ),
                            heightSpace10,
                            Divider(),
                          ],
                        ),
                      ),
                    ),
                    /*   InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RequestDashboard()),
                        );
                      },
                      child: Container(
                        child: Column(
                          children: [
                            heightSpace10,
                            Row(
                              children: [
                                widthSpace20,
                                Icon(Icons.location_on_outlined),
                                widthSpace10,
                                Text(
                                  "Request dashboard",
                                  style: OTPHeading14TextStyle,
                                  textScaleFactor: geTextScale(),
                                ),
                              ],
                            ),
                            heightSpace10,
                            Divider(),
                          ],
                        ),
                      ),
                    ),*/
                    /*Container(
                      child: Column(
                        children: [
                          heightSpace10,
                          Row(
                            children: [
                              widthSpace20,
                              Icon(Icons.chat_bubble_outline),
                              widthSpace10,
                              Text(
                                "Chat with us",
                                style: OTPHeading14TextStyle,
                                textScaleFactor: geTextScale(),
                              ),
                            ],
                          ),
                          heightSpace10,
                          Divider(),
                        ],
                      ),
                    ),*/
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ManageTimingScreen()),
                        );
                      },
                      child: Container(
                        child: Column(
                          children: [
                            heightSpace10,
                            Row(
                              children: [
                                widthSpace20,
                                Icon(Icons.edit_calendar_outlined),
                                widthSpace10,
                                Text(
                                  "Manage Timing",
                                  style: OTPHeading14TextStyle,
                                  textScaleFactor: geTextScale(),
                                ),
                              ],
                            ),
                            heightSpace10,
                            Divider(),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          heightSpace10,
                          Row(
                            children: [
                              widthSpace20,
                              Icon(Icons.phone_outlined),
                              widthSpace10,
                              Text(
                                "Talk to our Support",
                                style: OTPHeading14TextStyle,
                                textScaleFactor: geTextScale(),
                              ),
                            ],
                          ),
                          heightSpace10,
                          Divider(),
                        ],
                      ),
                    )
                  ],
                )),
            Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        storage.remove("token");
                        storage.remove("vendorId");
                        storage.remove("vendorName");
                        storage.remove("ownerName");
                        storage.remove("mobile");
                        storage.remove("thumbnail");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VendorLoadingScreen()),
                        );
                      },
                      child: Text(
                        'Logout',
                        style: button16TextStyle,
                        textScaleFactor: geTextScale(),
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0.sp),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(primaryColor),
                        /*padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(
                                horizontal: 110.sp, vertical: 15.sp)),*/
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
