import 'dart:io';

import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/model/document_type.dart';
import 'package:entekaravendor/pages/Dashboard/view/home_screen.dart';
import 'package:entekaravendor/pages/Signup/bloc/sign_up_bloc.dart';
import 'package:entekaravendor/pages/Signup/data/sign_up_api.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:entekaravendor/widgets/common_appbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../model/vendorType_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen(
      {Key? key,
      this.longitude,
      this.lattitide,
      this.userId,
      this.phoneNumber,
      this.state,
      this.locality,
      this.district,
      this.pincode})
      : super(key: key);
  final double? lattitide;
  final double? longitude;
  final int? userId;
  final String? phoneNumber;
  final String? state;
  final String? district;
  final String? locality;
  final String? pincode;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController storeNameController = new TextEditingController();
  final TextEditingController addressController = new TextEditingController();
  final TextEditingController contactController = new TextEditingController();
  final TextEditingController ownerController = new TextEditingController();
  final TextEditingController gstController = new TextEditingController();
  final TextEditingController pincodeController = new TextEditingController();
  final TextEditingController stateController = new TextEditingController();
  final TextEditingController districtController = new TextEditingController();
  final TextEditingController localityController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  String? type, type1;
  String? vendorType_id, document_type;
  bool isdropDown = false, isDropDown1 = false;
  final SignUpApi _signUpApi = SignUpApi();
  VendorTypeModel? dropDownData;
  DocumentTypeModel? documentTypeData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeData();

    getDocumentType();
    getVendorType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(getProportionateScreenHeight(50)),
          child: commonAppbar("Your Information", context)),
      body: SafeArea(
        child: BlocProvider(
          create: (context) =>
              SignUpBloc()..add(const FetchTypeEvent("1", "Type")),
          child: SingleChildScrollView(
            child: BlocListener<SignUpBloc, SignUpState>(
              listener: (context, state) {
                if (state is Signup1Success) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Container(
                        height: getProportionateScreenHeight(40),
                        child: Text("Your profile updated successfully !!")),
                    duration: const Duration(seconds: 4),
                    action: SnackBarAction(
                      label: '',
                      onPressed: () {},
                    ),
                  ));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                } else if (state is Signup1Error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Container(
                        height: getProportionateScreenHeight(40),
                        child: Text(state.error)),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {},
                    ),
                  ));
                }
              },
              child: BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Center(
                          child: SizedBox(
                            height: getProportionateScreenHeight(150),
                            width: getProportionateScreenWidth(150),
                            child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.expand,
                              children: [
                                (_croppedImage != null)
                                    ? Center(
                                        child: Image.file(
                                        File(_croppedImage!.path),
                                        width: getProportionateScreenWidth(200),
                                        height:
                                            getProportionateScreenHeight(200),
                                      ))
                                    : Center(
                                        child: Image.asset(
                                        "assets/images/men.png",
                                      )),
                                Positioned(
                                    bottom: 0,
                                    right: getProportionateScreenWidth(-25),
                                    child: RawMaterialButton(
                                      onPressed: () {
                                        _pickImage();
                                      },
                                      elevation: 2.0,
                                      fillColor: orangeColor,
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.all(
                                          getProportionateScreenHeight(15)),
                                      shape: CircleBorder(),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        heightSpace10,
                        Center(
                          child: Text(
                            "Add some images of your store",
                            style: change14TextStyle,
                            textScaleFactor: geTextScale(),
                          ),
                        ),
                        heightSpace30,
                        Padding(
                          padding: EdgeInsets.only(
                              top: getProportionateScreenHeight(10),
                              bottom: getProportionateScreenHeight(8),
                              left: getProportionateScreenWidth(20),
                              right: getProportionateScreenWidth(20)),
                          child: TextFormField(
                            cursorColor: primaryColor,
                            textCapitalization: TextCapitalization.words,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: getProportionateScreenHeight(12)),
                            decoration: new InputDecoration(
                              prefixIcon: Icon(Icons.store_outlined),
                              labelText: "Store Name",
                              labelStyle: TextStyle(
                                  fontSize: getProportionateScreenHeight(14)),
                              //floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFE1DFDD), width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFE1DFDD), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
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
                            textCapitalization: TextCapitalization.words,
                            cursorColor: primaryColor,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: getProportionateScreenHeight(12)),
                            decoration: new InputDecoration(
                              prefixIcon: Icon(Icons.account_circle),
                              labelText: "Owner Name",
                              labelStyle: TextStyle(
                                  fontSize: getProportionateScreenHeight(14)),
                              //floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFE1DFDD), width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFE1DFDD), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
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
                            textCapitalization: TextCapitalization.words,
                            cursorColor: primaryColor,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: getProportionateScreenHeight(12)),
                            decoration: new InputDecoration(
                              prefixIcon: Icon(Icons.storefront),
                              labelText: "Store Address",
                              labelStyle: TextStyle(
                                  fontSize: getProportionateScreenHeight(14)),
                              //floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFE1DFDD), width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFE1DFDD), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
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
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: getProportionateScreenHeight(12)),
                            decoration: new InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined),
                              labelText: "Email",
                              labelStyle: TextStyle(
                                  fontSize: getProportionateScreenHeight(14)),
                              //floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFE1DFDD), width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFE1DFDD), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.blue)),
                              contentPadding: EdgeInsets.only(
                                  bottom: 10.0, left: 10.0, right: 10.0),
                            ),
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (name) {
                              if (name == "") {
                                return 'Email is required.';
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
                              labelStyle: TextStyle(
                                  fontSize: getProportionateScreenHeight(14)),
                              //floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFE1DFDD), width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFE1DFDD), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
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
                            textCapitalization: TextCapitalization.characters,
                            cursorColor: primaryColor,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: getProportionateScreenHeight(12)),
                            decoration: new InputDecoration(
                              prefixIcon: Icon(Icons.numbers),
                              labelText: "Gst Number",
                              labelStyle: TextStyle(
                                  fontSize: getProportionateScreenWidth(14)),
                              //floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFE1DFDD), width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFE1DFDD), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
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
                              prefixIcon: Icon(Icons.pin),
                              labelText: "Pincode*",
                              labelStyle: TextStyle(
                                  fontSize: getProportionateScreenHeight(14)),
                              //floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFE1DFDD), width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFE1DFDD), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.blue)),
                              contentPadding: EdgeInsets.only(
                                  bottom: 10.0, left: 10.0, right: 10.0),
                            ),
                            controller: pincodeController,
                            keyboardType: TextInputType.number,
                            validator: (name) {
                              if (name == "") {
                                return 'Pincode is required.';
                              } else if (name!.length != 6) {
                                return 'Pincode must be 6 digit.';
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
                              prefixIcon: Icon(Icons.location_on_outlined),
                              labelText: "Locality*",
                              labelStyle: TextStyle(
                                  fontSize: getProportionateScreenHeight(14)),
                              //floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFE1DFDD), width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFE1DFDD), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.blue)),
                              contentPadding: EdgeInsets.only(
                                  bottom: 10.0, left: 10.0, right: 10.0),
                            ),
                            controller: localityController,
                            keyboardType: TextInputType.text,
                            validator: (name) {
                              if (name == "") {
                                return 'Locality is required.';
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
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: getProportionateScreenHeight(12)),
                            decoration: new InputDecoration(
                              prefixIcon: Icon(Icons.location_on_outlined),
                              labelText: "District*",
                              labelStyle: TextStyle(
                                  fontSize: getProportionateScreenHeight(14)),
                              //floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFE1DFDD), width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFE1DFDD), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.blue)),
                              contentPadding: EdgeInsets.only(
                                  bottom: 10.0, left: 10.0, right: 10.0),
                            ),
                            controller: districtController,
                            keyboardType: TextInputType.text,
                            validator: (name) {
                              if (name == "") {
                                return 'District is required.';
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
                              prefixIcon: Icon(Icons.location_on_outlined),
                              labelText: "State*",
                              labelStyle: TextStyle(
                                  fontSize: getProportionateScreenHeight(14)),
                              //floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFE1DFDD), width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFE1DFDD), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.blue)),
                              contentPadding: EdgeInsets.only(
                                  bottom: 10.0, left: 10.0, right: 10.0),
                            ),
                            controller: stateController,
                            keyboardType: TextInputType.text,
                            validator: (name) {
                              if (name == "") {
                                return 'State is required.';
                              }
                              return null;
                            },
                          ),
                        ),
                        //heightSpace30,

                        Padding(
                          padding: EdgeInsets.only(
                              bottom: getProportionateScreenHeight(8),
                              left: getProportionateScreenWidth(20),
                              right: getProportionateScreenWidth(20)),
                          child: isdropDown
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : dropDown(
                                  'Vendor Type*',
                                  dropDownData!.data![0].name!,
                                  type, (String? newValue) {
                                  setState(() {
                                    type = newValue!;
                                    print("new value= $newValue");
                                    vendorType_id = newValue!;
                                  });
                                }, dropDownData!.data!),
                        ),

                        heightSpace10,
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: getProportionateScreenHeight(8),
                              left: getProportionateScreenWidth(20),
                              right: getProportionateScreenWidth(20)),
                          child: isDropDown1
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : dropDown(
                                  'Document Type*',
                                  documentTypeData!.data![0].name!,
                                  type1, (String? newValue) {
                                  setState(() {
                                    type1 = newValue!;
                                    print("new value= $newValue");
                                    document_type = newValue!;
                                  });
                                }, documentTypeData!.data!),
                        ),

                        heightSpace20,
                        Text(
                          "Document",
                          textScaleFactor: textFactor,
                          style: OTPHeading11TextStyle,
                        ),
                        GestureDetector(
                          onTap: () {
                            _pickFile();
                          },
                          child: (_image2 != null)
                              ? Text("File Name: ${_image2!.path}")
                              : Container(
                                  height: getProportionateScreenHeight(100),
                                  width: getProportionateScreenHeight(100),
                                  decoration: BoxDecoration(
                                    color: backgroundColor,
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                        "assets/images/add_photo.png"),
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
                          child: GestureDetector(
                            onTap: () {
                              if (vendorType_id == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Vendor Type Required"),
                                  duration: const Duration(seconds: 2),
                                  action: SnackBarAction(
                                    label: 'OK',
                                    onPressed: () {},
                                  ),
                                ));
                              } else if (storeNameController.text == "") {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Store name Required"),
                                  duration: const Duration(seconds: 2),
                                  action: SnackBarAction(
                                    label: 'OK',
                                    onPressed: () {},
                                  ),
                                ));
                              } else if (ownerController.text == "") {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Owner name Required"),
                                  duration: const Duration(seconds: 2),
                                  action: SnackBarAction(
                                    label: 'OK',
                                    onPressed: () {},
                                  ),
                                ));
                              } else if (addressController.text == "") {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Address Required"),
                                  duration: const Duration(seconds: 2),
                                  action: SnackBarAction(
                                    label: 'OK',
                                    onPressed: () {},
                                  ),
                                ));
                              } else if (districtController.text == "") {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("District Required"),
                                  duration: const Duration(seconds: 2),
                                  action: SnackBarAction(
                                    label: 'OK',
                                    onPressed: () {},
                                  ),
                                ));
                              } else {
                                final DateTime now = DateTime.now();
                                final DateFormat formatter =
                                    DateFormat('yyyy-MM-dd');
                                final String formatted = formatter.format(now);
                                if (_croppedImage == null &&
                                    _croppedImage1 == null) {
                                  context.read<SignUpBloc>().add(SignUp2Event(
                                      widget.userId!,
                                      storeNameController.text,
                                      ownerController.text,
                                      int.parse(vendorType_id!),
                                      int.parse(contactController.text),
                                      addressController.text,
                                      gstController.text,
                                      int.parse(pincodeController.text),
                                      stateController.text,
                                      districtController.text,
                                      localityController.text,
                                      widget.lattitide!,
                                      widget.longitude!,
                                      formatted,
                                      emailController.text,
                                      document_type!));
                                } else {
                                  context.read<SignUpBloc>().add(SignUp1Event(
                                      File(_croppedImage!.path),
                                      widget.userId!,
                                      storeNameController.text,
                                      ownerController.text,
                                      int.parse(vendorType_id!),
                                      int.parse(contactController.text),
                                      addressController.text,
                                      gstController.text,
                                      int.parse(pincodeController.text),
                                      stateController.text,
                                      districtController.text,
                                      localityController.text,
                                      widget.lattitide!,
                                      widget.longitude!,
                                      formatted,
                                      File(_image2!.path),
                                      emailController.text,
                                      document_type!));
                                }
                              }
                            },
                            child: Container(
                              height: getProportionateScreenHeight(30),
                              width: getProportionateScreenWidth(182),
                              padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(10),
                                top: getProportionateScreenHeight(5),
                                right: getProportionateScreenWidth(10),
                                bottom: getProportionateScreenHeight(5),
                              ),
                              decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Center(
                                child: Text(
                                  'Request Approval',
                                  style: Text12TextTextStyle,
                                  textScaleFactor: textFactor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dropDownWithSearch(
    String hint,
    String? assignedTo,
    void Function(String?)? onChanged,
    List data,
  ) {
    TextEditingController controller = TextEditingController();
    if (assignedTo != null) {
      var selectedItem = data.firstWhere((item) => item.id == assignedTo);
      if (selectedItem != null) {
        controller.text = selectedItem.val;
      }
    }
    return Container(
      height: 40,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: fixPadding,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: greyColor.withOpacity(.2), width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TypeAheadFormField<String>(
        getImmediateSuggestions: false,
        hideSuggestionsOnKeyboardHide: true,
        hideOnEmpty: true,
        textFieldConfiguration: TextFieldConfiguration(
          style: black14SemiBoldTextStyle,
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: grey15RegularTextStyle,
            border: InputBorder.none,
          ),
        ),
        suggestionsCallback: (pattern) async {
          return data
              .where((item) =>
                  item.val.toLowerCase().contains(pattern.toLowerCase()))
              .map((item) => item.val);
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(
              suggestion,
              style: black14SemiBoldTextStyle,
            ),
          );
        },
        onSuggestionSelected: (suggestion) {
          setState(() {
            dynamic selectedItem =
                data.firstWhere((item) => item.val == suggestion);

            if (selectedItem != null) {
              onChanged!(selectedItem.id);
              controller.text = selectedItem.val;
            } else {
              onChanged!(
                  null); // No item found, pass null to the onChanged callback.
            }
          });
        },
        noItemsFoundBuilder: (context) {
          return const SizedBox.shrink();
        },
        loadingBuilder: (context) {
          return const SizedBox.shrink();
        },
      ),
    );
  }

  dropDown(String heading, String hint, String? assignedTo,
      void Function(String?)? onChanged, List data) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(
        horizontal: fixPadding,
        vertical: fixPadding / 2,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE1DFDD), width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          elevation: 0,
          isDense: true,
          hint: Text(
            hint,
            style: grey15RegularTextStyle,
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: primaryColor,
            size: 20,
          ),
          value: assignedTo,
          style: black14SemiBoldTextStyle,
          onChanged: onChanged,
          items: data.map((value) {
            return DropdownMenuItem<String>(
              value: value.id.toString(),
              child: Text(value.name),
            );
          }).toList(),
        ),
      ),
    );
  }

  File? _image, _image1, _image2;
  CroppedFile? _croppedImage, _croppedImage1;

  Future<void> _cropImage() async {
    if (_image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: _image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _croppedImage = croppedFile;
        });
      }
    }
  }

  Future _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      _cropImage();
    }
  }

  Future _pickImage1() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image1 = File(pickedImage.path);
      });
      _cropImage1();
    }
  }

  _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        _image2 = File(result.files.single.path!);
      });
    } else {
      print("No file selected");
    }
  }

  Future<void> _cropImage1() async {
    if (_image1 != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: _image1!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _croppedImage1 = croppedFile;
        });
      }
    }
  }

  void initializeData() {
    contactController.text = widget.phoneNumber!;
    pincodeController.text = widget.pincode!;
    localityController.text = widget.locality!;
    stateController.text = widget.state!;
    districtController.text = widget.district!;
  }

  Future<void> getVendorType() async {
    setState(() {
      isdropDown = true;
    });
    try {
      final response = await _signUpApi.getDropDownData("1", "type");

      if (response["message"] == "Success") {
        dropDownData = VendorTypeModel.fromJson(response);
        setState(() {
          isdropDown = false;
        });
      } else if (response["message"] != "Success") {
        Fluttertoast.showToast(msg: response["message"]);
        setState(() {
          isdropDown = false;
        });
      } else {
        Fluttertoast.showToast(msg: response["errmessage"]);
        setState(() {
          isdropDown = false;
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      setState(() {
        isdropDown = false;
      });
    }
  }

  Future<void> getDocumentType() async {
    setState(() {
      isDropDown1 = true;
    });
    try {
      final response = await _signUpApi.getDocumentType();

      if (response["message"] == "Success") {
        documentTypeData = DocumentTypeModel.fromJson(response);
      } else if (response["message"] != "Success") {
        Fluttertoast.showToast(msg: response["message"]);
        setState(() {
          isdropDown = false;
        });
      } else {
        Fluttertoast.showToast(msg: response["errmessage"]);
        setState(() {
          isdropDown = false;
        });
      }
      setState(() {
        isDropDown1 = false;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      setState(() {
        isDropDown1 = false;
      });
    }
  }
}
