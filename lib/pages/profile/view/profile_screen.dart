import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:entekaravendor/pages/edit_profile/view/myprofile.dart';
import 'package:entekaravendor/pages/manage_time/view/ManageTimeDetails.dart';
import 'package:entekaravendor/pages/vendor_login/vendor_loading/view/vendor_loading.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:entekaravendor/widgets/profile_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  int vendorId = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    extension = p.extension(storage.read("thumbnail"));
    vendorId = int.parse(storage.read("vendorId").toString());
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
        child: BlocProvider(
          create: (context) => ProfileBloc()..add(FetchProfile(vendorId)),
          child: Column(
            children: [
              Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      heightSpace10,
                      BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                        if (state is ProfileLoadingState) {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: primaryColor,
                          ));
                        } else if (state is ProfileLoadedState) {
                          return getUserData(state, context);
                        } else if (state is ErrorState) {
                          return Padding(
                              padding: EdgeInsets.all(
                                  getProportionateScreenHeight(16)),
                              child: Center(child: Text(state.error)));
                        } else {
                          return Container();
                        }
                      }),
                      heightSpace10,
                      Divider(),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyProfile()),
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ManageTimeDetails()),
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
                      InkWell(
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

  Widget getUserData(ProfileLoadedState state, BuildContext context) {
    return Column(
      children: [
        Center(
            child:
                p.extension(state.profileData!.data!.thumbnailImage!) != ".svg"
                    ? CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(
                            "${state.profileData!.data!.thumbnailImage!}"),
                        backgroundColor: Colors.transparent,
                      )
                    : SvgPicture.network(
                        state.profileData!.data!.thumbnailImage! ?? '',
                        fit: BoxFit.cover,
                      )),
        heightSpace10,
        Center(
          child: Column(
            children: [
              Text(
                '${state.profileData!.data!.vendorName!}',
                style: heading18TextStyle,
                textScaleFactor: geTextScale(),
              ),
              heightSpace,
              Text(
                '${state.profileData!.data!.contact1!}',
                style: Text10STextStyle,
                textScaleFactor: geTextScale(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
