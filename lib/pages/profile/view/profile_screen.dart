import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/edit_profile/view/edit_profile.dart';
import 'package:entekaravendor/pages/request_dashboard/view/request_dashboard.dart';
import 'package:entekaravendor/widgets/profile_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0.sp),
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
                            AssetImage("assets/images/vendor_image.png"),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    heightSpace10,
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "VK Stores",
                            style: heading18TextStyle,
                            textScaleFactor: textFactor,
                          ),
                          Text(
                            "94xxxxxxxx",
                            style: Text10STextStyle,
                            textScaleFactor: textFactor,
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
                                  textScaleFactor: textFactor,
                                ),
                              ],
                            ),
                            heightSpace10,
                            Divider(),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
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
                                  textScaleFactor: textFactor,
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
                              Icon(Icons.chat_bubble_outline),
                              widthSpace10,
                              Text(
                                "Chat with us",
                                style: OTPHeading14TextStyle,
                                textScaleFactor: textFactor,
                              ),
                            ],
                          ),
                          heightSpace10,
                          Divider(),
                        ],
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
                                textScaleFactor: textFactor,
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
                      onPressed: () {},
                      child: Text(
                        'Logout',
                        style: button16TextStyle,
                        textScaleFactor: textFactor,
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
