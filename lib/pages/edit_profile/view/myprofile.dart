import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:entekaravendor/pages/edit_profile/view/edit_profile.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:entekaravendor/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart' as p;

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController storeNameController = new TextEditingController();
  final TextEditingController addressController = new TextEditingController();
  final TextEditingController contactController = new TextEditingController();
  final TextEditingController ownerController = new TextEditingController();
  final TextEditingController gstController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();

  final storage = GetStorage();
  int vendorId = 0;
  String initialCountry = 'IN';
  String imagePath = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vendorId = int.parse(storage.read("vendorId").toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(getProportionateScreenHeight(50)),
          child: commonAppbar("My Profile", context)),
      body: BlocProvider(
        create: (context) => ProfileBloc()..add(FetchProfile(vendorId)),
        child: SafeArea(
            child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {},
          child:
              BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            if (state is ProfileLoadingState) {
              return const Center(
                  child: CircularProgressIndicator(
                color: primaryColor,
              ));
            } else if (state is ProfileLoadedState) {
              initializeData(state);
              return getProfileDetails(state, context);
            } else if (state is ErrorState) {
              return Padding(
                  padding: EdgeInsets.all(getProportionateScreenHeight(16)),
                  child: Center(child: Text(state.error)));
            } else {
              return Container();
            }
          }),
        )),
      ),
    );
  }

  Widget getProfileDetails(ProfileLoadedState state, BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 8,
            child: Column(
              children: [
                heightSpace10,
                Center(
                  child: SizedBox(
                    height: getProportionateScreenHeight(150),
                    width: getProportionateScreenWidth(150),
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        p.extension(state.profileData!.data!.thumbnailImage!) !=
                                ".svg"
                            ? CircleAvatar(
                                radius: 60.0,
                                backgroundImage: NetworkImage(imagePath),
                                backgroundColor: Colors.transparent,
                              )
                            : SvgPicture.network(
                                storage.read("thumbnail") ?? '',
                                fit: BoxFit.cover,
                              ),
                        /*Positioned(
                            bottom: 0,
                            right: getProportionateScreenWidth(-25),
                            child: RawMaterialButton(
                              onPressed: () {},
                              elevation: 2.0,
                              fillColor: orangeColor,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(
                                  getProportionateScreenHeight(15)),
                              shape: CircleBorder(),
                            )),*/
                      ],
                    ),
                  ),
                ),
                heightSpace20,
                Padding(
                  padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(10),
                      bottom: getProportionateScreenHeight(8),
                      left: getProportionateScreenWidth(20),
                      right: getProportionateScreenWidth(20)),
                  child: TextFormField(
                    cursorColor: primaryColor,
                    enabled: false,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenHeight(12)),
                    decoration: new InputDecoration(
                      prefixIcon: Icon(Icons.store_outlined),
                      labelText: "Store Name",
                      labelStyle:
                          TextStyle(fontSize: getProportionateScreenHeight(14)),
                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: Color(0xFFE1DFDD), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: Color(0xFFE1DFDD), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.blue)),
                      contentPadding: EdgeInsets.only(
                          bottom: 10.0, left: 10.0, right: 10.0),
                    ),
                    controller: storeNameController,
                    keyboardType: TextInputType.text,
                    validator: (name) {
                      if (name == "") {
                        return 'Store name is required.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(10),
                      bottom: getProportionateScreenHeight(8),
                      left: getProportionateScreenWidth(20),
                      right: getProportionateScreenWidth(20)),
                  child: TextFormField(
                    enabled: false,
                    cursorColor: primaryColor,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenHeight(12)),
                    decoration: new InputDecoration(
                      prefixIcon: Icon(Icons.account_circle),
                      labelText: "Owner Name",
                      labelStyle:
                          TextStyle(fontSize: getProportionateScreenHeight(14)),
                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: Color(0xFFE1DFDD), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: Color(0xFFE1DFDD), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.blue)),
                      contentPadding: EdgeInsets.only(
                          bottom: 10.0, left: 10.0, right: 10.0),
                    ),
                    controller: ownerController,
                    keyboardType: TextInputType.text,
                    validator: (name) {
                      if (name == "") {
                        return 'Owner name is required.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(10),
                      bottom: getProportionateScreenHeight(8),
                      left: getProportionateScreenWidth(20),
                      right: getProportionateScreenWidth(20)),
                  child: TextFormField(
                    enabled: false,
                    cursorColor: primaryColor,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenHeight(12)),
                    decoration: new InputDecoration(
                      prefixIcon: Icon(Icons.storefront),
                      labelText: "Store Address",
                      labelStyle:
                          TextStyle(fontSize: getProportionateScreenHeight(14)),
                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: Color(0xFFE1DFDD), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: Color(0xFFE1DFDD), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.blue)),
                      contentPadding: EdgeInsets.only(
                          bottom: 10.0, left: 10.0, right: 10.0),
                    ),
                    controller: addressController,
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    validator: (name) {
                      if (name == "") {
                        return 'Store address is required.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(10),
                      bottom: getProportionateScreenHeight(8),
                      left: getProportionateScreenWidth(20),
                      right: getProportionateScreenWidth(20)),
                  child: TextFormField(
                    cursorColor: primaryColor,
                    enabled: false,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenHeight(12)),
                    decoration: new InputDecoration(
                      prefixIcon: Icon(Icons.phone_outlined),
                      labelText: "Contact",
                      labelStyle:
                          TextStyle(fontSize: getProportionateScreenHeight(14)),
                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: Color(0xFFE1DFDD), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: Color(0xFFE1DFDD), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.blue)),
                      contentPadding: EdgeInsets.only(
                          bottom: 10.0, left: 10.0, right: 10.0),
                    ),
                    controller: contactController,
                    keyboardType: TextInputType.number,
                    validator: (name) {
                      if (name == "") {
                        return 'Contact is required.';
                      } else if (name!.length != 10) {
                        return 'Contact must be 10 digit.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(10),
                      bottom: getProportionateScreenHeight(8),
                      left: getProportionateScreenWidth(20),
                      right: getProportionateScreenWidth(20)),
                  child: TextFormField(
                    enabled: false,
                    cursorColor: primaryColor,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenHeight(12)),
                    decoration: new InputDecoration(
                      prefixIcon: Icon(Icons.numbers),
                      labelText: "Gst Number",
                      labelStyle:
                          TextStyle(fontSize: getProportionateScreenWidth(14)),
                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: Color(0xFFE1DFDD), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: Color(0xFFE1DFDD), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.blue)),
                      contentPadding: EdgeInsets.only(
                          bottom: 10.0, left: 10.0, right: 10.0),
                    ),
                    controller: gstController,
                    keyboardType: TextInputType.text,
                    validator: (name) {
                      Pattern pattern =
                          r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$';
                      RegExp regex = RegExp(pattern.toString());
                      if (!regex.hasMatch(name!)) {
                        return 'Invalid GST Number.';
                      }

                      return null;
                    },
                  ),
                ),
              ],
            )),
        Expanded(
            flex: 1,
            child: Padding(
                padding:
                    EdgeInsets.only(bottom: getProportionateScreenHeight(20)),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile()),
                      );
                    },
                    child: Container(
                      height: getProportionateScreenHeight(30),
                      width: getProportionateScreenWidth(182),
                      padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(50),
                        top: getProportionateScreenHeight(5),
                        right: getProportionateScreenWidth(50),
                        bottom: getProportionateScreenHeight(5),
                      ),
                      decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: loginText(),
                    ),
                  ),
                )))
      ],
    );
  }

  loginText() {
    return Center(
      child: Text(
        'Edit Profile',
        style: Text12TextTextStyle,
        textScaleFactor: textFactor,
      ),
    );
  }

  void initializeData(ProfileLoadedState state) {
    storeNameController.text = state.profileData!.data!.vendorName!;
    ownerController.text = state.profileData!.data!.ownerName!;
    addressController.text = state.profileData!.data!.address!;
    contactController.text = state.profileData!.data!.contact1!;

    gstController.text = state.profileData!.data!.gstNumber == null
        ? ""
        : state.profileData!.data!.gstNumber!;
    imagePath = state.profileData!.data!.thumbnailImage!;
  }
}
