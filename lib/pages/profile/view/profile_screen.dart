import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/edit_profile/view/myprofile.dart';
import 'package:entekaravendor/pages/manage_time/view/manage_time.dart';
import 'package:entekaravendor/pages/vendor_login/vendor_loading/view/vendor_loading.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:entekaravendor/widgets/profile_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart' as p;
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final storage = GetStorage();
  String? extension;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    extension = p.extension(storage.read("thumbnail"));
    print(extension);
  }

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
                      child: extension != ".svg"
                          ? CircleAvatar(
                              radius: 60.0,
                              backgroundImage:
                                  NetworkImage("${storage.read("thumbnail")}"),
                              backgroundColor: Colors.transparent,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(60.0),
                              child: SvgPicture.network(
                                storage.read("thumbnail") ?? '',
                                fit: BoxFit.cover,
                              ),
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
                          heightSpace,
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyProfile()),
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
                                  "My Profile",
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
                    GestureDetector(
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
                    GestureDetector(
                      onTap: () {
                        _makePhoneCall();
                      },
                      child: Container(
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
                        style: Text12TextTextStyle,
                        textScaleFactor: geTextScale(),
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0.sp),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(backgroundColor),
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

  Future<void> _makePhoneCall() async {
    String phoneNumber = "9544313336";
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
