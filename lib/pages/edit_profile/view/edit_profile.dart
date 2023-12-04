import 'dart:io';

import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/model/profile_model.dart';
import 'package:entekaravendor/model/vendorType_model.dart';
import 'package:entekaravendor/pages/Signup/data/sign_up_api.dart';
import 'package:entekaravendor/pages/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:entekaravendor/pages/edit_profile/data/edit_profile_api.dart';
import 'package:entekaravendor/pages/edit_profile/data/edit_profile_repo.dart';
import 'package:entekaravendor/pages/edit_profile/view/location_edit_details.dart';
import 'package:entekaravendor/pages/edit_profile/view/myprofile.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:entekaravendor/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController storeNameController = new TextEditingController();
  final TextEditingController addressController = new TextEditingController();
  final TextEditingController contactController = new TextEditingController();
  final TextEditingController ownerController = new TextEditingController();
  final TextEditingController gstController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController contact2Controller = new TextEditingController();
  final ProfileApi _profileApi = ProfileApi();
  final ProfileRepository _profileRepository = ProfileRepository();
  final storage = GetStorage();
  int vendorId = 0;
  String initialCountry = 'IN';
  String imagePath = "";
  String? type;
  String? vendorType_id;
  bool isdropDown = false, isImageFound = false, isUpload = false;
  final SignUpApi _signUpApi = SignUpApi();
  VendorTypeModel? dropDownData;
  ProfileModel? profileModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vendorId = int.parse(storage.read("vendorId").toString());

    getProfileData();
    getDropDownData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(getProportionateScreenHeight(50)),
          child: commonAppbar("Edit Profile", context)),
      body: BlocProvider(
        create: (context) => ProfileBloc()
          ..add(FetchProfile(vendorId))
          ..add(FetchTypeEvent("1", "Type")),
        child: SafeArea(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              (_croppedImage != null)
                                  ? Center(
                                      child: Image.file(
                                      File(_croppedImage!.path),
                                      width: getProportionateScreenWidth(200),
                                      height: getProportionateScreenHeight(200),
                                    ))
                                  : p.extension(storage.read("thumbnail")) !=
                                          ".svg"
                                      ? CircleAvatar(
                                          radius: 60.0,
                                          backgroundImage:
                                              NetworkImage(imagePath),
                                          backgroundColor: Colors.transparent,
                                        )
                                      : SvgPicture.network(
                                          storage.read("thumbnail") ?? '',
                                          fit: BoxFit.cover,
                                        ),
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
                      heightSpace20,
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
                          cursorColor: primaryColor,
                          textCapitalization: TextCapitalization.words,
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
                          cursorColor: primaryColor,
                          textCapitalization: TextCapitalization.words,
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
                          cursorColor: primaryColor,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: getProportionateScreenHeight(12)),
                          decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.phone_outlined),
                            labelText: "Another Contact",
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
                          controller: contact2Controller,
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
                          cursorColor: primaryColor,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: getProportionateScreenHeight(12)),
                          decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.numbers),
                            labelText: "Email",
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
                            bottom: getProportionateScreenHeight(8),
                            left: getProportionateScreenWidth(20),
                            right: getProportionateScreenWidth(20)),
                        child: isdropDown == false
                            ? dropDown(
                                'Vendor Type*',
                                dropDownData!.data![0].name!,
                                type, (String? newValue) {
                                setState(() {
                                  type = newValue!;
                                  print("new value= $newValue");
                                  vendorType_id = newValue!;
                                });
                              }, dropDownData!.data!)
                            : Center(child: CircularProgressIndicator()),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: getProportionateScreenHeight(10),
                            bottom: getProportionateScreenHeight(8),
                            left: getProportionateScreenWidth(20),
                            right: getProportionateScreenWidth(20)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocationEditDetails(
                                        profileData: profileModel!.data,
                                        vendorName: storeNameController.text,
                                        ownerName: ownerController.text,
                                        storeAddress: addressController.text,
                                        contact2: contact2Controller.text,
                                        email: emailController.text,
                                        gstNumber: gstController.text,
                                        image: File(_croppedImage!.path),
                                        imageFound: isImageFound,
                                        vendor_type: vendorType_id,
                                      )),
                            );
                          },
                          child: Text(
                            "Edit Location Details",
                            style: heading18TextStyle,
                            textScaleFactor: geTextScale(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                      padding: EdgeInsets.only(
                          bottom: getProportionateScreenHeight(20)),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            if (_croppedImage != null) {
                              getImageUploadDetails();
                            } else {
                              getUploadData();
                            }
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: isUpload ? loadingText() : loginText(),
                          ),
                        ),
                      ))),
            ],
          ),
        )),
      ),
    );
  }

  void initializeData(ProfileModel profileData) {
    storeNameController.text = profileData.data!.vendorName!;
    ownerController.text = profileData.data!.ownerName!;
    addressController.text = profileData.data!.address!;
    contactController.text = profileData.data!.contact1!;
    gstController.text =
        profileData.data!.gstNumber == null ? "" : profileData.data!.gstNumber!;
    contact2Controller.text =
        profileData.data!.contact2 == null ? "" : profileData.data!.contact2!;
    imagePath = profileData.data!.thumbnailImage!;
  }

  loginText() {
    return Center(
      child: Text(
        'Save Changes',
        style: Text12TextTextStyle,
        textScaleFactor: textFactor,
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

  File? _image;
  CroppedFile? _croppedImage;

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
          isImageFound = true;
        });
      } else {
        isImageFound = false;
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

  Future<void> getProfileData() async {
    try {
      final response = await _profileApi.getProfileDetails(vendorId);
      if (response["message"] == "Success") {
        profileModel = ProfileModel.fromJson(response);
        initializeData(profileModel!);
      } else if (response["message"] != "Success") {
        Fluttertoast.showToast(msg: response["message"]);
      } else {
        Fluttertoast.showToast(msg: response["errmessage"]);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> getDropDownData() async {
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

  Future<void> getImageUploadDetails() async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    setState(() {
      isUpload = true;
    });
    try {
      ProfileModel profileData = await _profileRepository.vendorEditProfile(
          File(_croppedImage!.path),
          profileModel!.data!.userId!,
          storeNameController.text,
          ownerController.text,
          int.parse(vendorType_id!),
          int.parse(contact2Controller.text),
          addressController.text,
          gstController.text,
          int.parse(profileModel!.data!.pincode!),
          profileModel!.data!.state!,
          profileModel!.data!.district!,
          profileModel!.data!.locality!,
          double.parse(profileModel!.data!.latitude!),
          double.parse(profileModel!.data!.longitude!),
          formatted,
          emailController.text);
      if (profileData.message == "Success") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyProfile()),
        );
      } else {
        Fluttertoast.showToast(msg: profileData.message.toString());
      }
      setState(() {
        isUpload = false;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      setState(() {
        isUpload = false;
      });
    }
  }

  Future<void> getUploadData() async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    setState(() {
      isUpload = true;
    });
    try {
      ProfileModel profileData = await _profileRepository.vendorEditProfile1(
          profileModel!.data!.userId!,
          storeNameController.text,
          ownerController.text,
          int.parse(vendorType_id!),
          int.parse(contact2Controller.text),
          addressController.text,
          gstController.text,
          int.parse(profileModel!.data!.pincode!),
          profileModel!.data!.state!,
          profileModel!.data!.district!,
          profileModel!.data!.locality!,
          double.parse(profileModel!.data!.latitude!),
          double.parse(profileModel!.data!.longitude!),
          formatted,
          emailController.text);
      if (profileData.message == "Success") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyProfile()),
        );
      } else {
        Fluttertoast.showToast(msg: profileData.message.toString());
      }
      setState(() {
        isUpload = false;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      setState(() {
        isUpload = false;
      });
    }
  }

  loadingText() {
    return SpinKitThreeBounce(
      color: Colors.white,
      size: getProportionateScreenHeight(10),
    );
  }
}
