import 'dart:io';
import 'dart:math';

import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/Dashboard/view/home_screen.dart';
import 'package:entekaravendor/pages/Signup/bloc/sign_up_bloc.dart';
import 'package:entekaravendor/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key, this.longitude, this.lattitide})
      : super(key: key);
  final double? lattitide;
  final double? longitude;

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
  String? type;
  String? vendorType_id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0.sp),
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
                    content: const Text("Your profile updated successfully !!"),
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
                    content: Text(state.error),
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
                        GestureDetector(
                          onTap: () {
                            _pickImage();
                          },
                          child: Container(
                            height: 100.sp,
                            width: 100.sp,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: backgroundColor,
                            ),
                            child: Center(
                              child: (_croppedImage != null)
                                  ? Image.file(
                                      File(_croppedImage!.path),
                                      width: 200,
                                      height: 200,
                                    )
                                  : Image.asset("assets/images/add_photo.png"),
                            ),
                          ),
                        ),
                        heightSpace10,
                        Center(
                          child: Text(
                            "Add some images of your store",
                            style: change14TextStyle,
                            textScaleFactor: textFactor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10.sp,
                              bottom: 8.sp,
                              left: 20.sp,
                              right: 20.sp),
                          child: TextFormField(
                            cursorColor: primaryColor,
                            style:
                                TextStyle(color: Colors.black, fontSize: 12.sp),
                            decoration: new InputDecoration(
                              prefixIcon: Icon(Icons.store_outlined),
                              labelText: "Store Name",
                              labelStyle: TextStyle(fontSize: 14.sp),
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
                            validator: (name) {},
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10.sp,
                              bottom: 8.sp,
                              left: 20.sp,
                              right: 20.sp),
                          child: TextFormField(
                            cursorColor: primaryColor,
                            style:
                                TextStyle(color: Colors.black, fontSize: 12.sp),
                            decoration: new InputDecoration(
                              prefixIcon: Icon(Icons.account_circle),
                              labelText: "Owner Name",
                              labelStyle: TextStyle(fontSize: 14.sp),
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
                            validator: (name) {},
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10.sp,
                              bottom: 8.sp,
                              left: 20.sp,
                              right: 20.sp),
                          child: TextFormField(
                            cursorColor: primaryColor,
                            style:
                                TextStyle(color: Colors.black, fontSize: 12.sp),
                            decoration: new InputDecoration(
                              prefixIcon: Icon(Icons.storefront),
                              labelText: "Store Address",
                              labelStyle: TextStyle(fontSize: 14.sp),
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
                            validator: (name) {},
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10.sp,
                              bottom: 8.sp,
                              left: 20.sp,
                              right: 20.sp),
                          child: TextFormField(
                            cursorColor: primaryColor,
                            style:
                                TextStyle(color: Colors.black, fontSize: 12.sp),
                            decoration: new InputDecoration(
                              prefixIcon: Icon(Icons.phone_outlined),
                              labelText: "Contact",
                              labelStyle: TextStyle(fontSize: 14.sp),
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
                            validator: (name) {},
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10.sp,
                              bottom: 8.sp,
                              left: 20.sp,
                              right: 20.sp),
                          child: TextFormField(
                            cursorColor: primaryColor,
                            style:
                                TextStyle(color: Colors.black, fontSize: 12.sp),
                            decoration: new InputDecoration(
                              prefixIcon: Icon(Icons.numbers),
                              labelText: "Gst Number",
                              labelStyle: TextStyle(fontSize: 14.sp),
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
                            validator: (name) {},
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10.sp,
                              bottom: 8.sp,
                              left: 20.sp,
                              right: 20.sp),
                          child: TextFormField(
                            cursorColor: primaryColor,
                            style:
                                TextStyle(color: Colors.black, fontSize: 12.sp),
                            decoration: new InputDecoration(
                              prefixIcon: Icon(Icons.pin),
                              labelText: "Pincode*",
                              labelStyle: TextStyle(fontSize: 14.sp),
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
                            validator: (name) {},
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10.sp,
                              bottom: 8.sp,
                              left: 20.sp,
                              right: 20.sp),
                          child: TextFormField(
                            cursorColor: primaryColor,
                            style:
                                TextStyle(color: Colors.black, fontSize: 12.sp),
                            decoration: new InputDecoration(
                              prefixIcon: Icon(Icons.location_on_outlined),
                              labelText: "State*",
                              labelStyle: TextStyle(fontSize: 14.sp),
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
                            validator: (name) {},
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10.sp,
                              bottom: 8.sp,
                              left: 20.sp,
                              right: 20.sp),
                          child: TextFormField(
                            cursorColor: primaryColor,
                            style:
                                TextStyle(color: Colors.black, fontSize: 12.sp),
                            decoration: new InputDecoration(
                              prefixIcon: Icon(Icons.location_on_outlined),
                              labelText: "District*",
                              labelStyle: TextStyle(fontSize: 14.sp),
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
                            validator: (name) {},
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10.sp,
                              bottom: 8.sp,
                              left: 20.sp,
                              right: 20.sp),
                          child: TextFormField(
                            cursorColor: primaryColor,
                            style:
                                TextStyle(color: Colors.black, fontSize: 12.sp),
                            decoration: new InputDecoration(
                              prefixIcon: Icon(Icons.location_on_outlined),
                              labelText: "Locality*",
                              labelStyle: TextStyle(fontSize: 14.sp),
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
                            validator: (name) {},
                          ),
                        ),
                        heightSpace30,
                        if (state is DropDownSuccess)
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 8.sp, left: 20.sp, right: 20.sp),
                            child: dropDown(
                                'Vendor Type*',
                                state.dropDownData!.data![0].name!,
                                type, (String? newValue) {
                              setState(() {
                                type = newValue!;
                                print("new value= $newValue");
                                vendorType_id = newValue!;
                              });
                            }, state.dropDownData!.data!),
                          ),
                        Text(
                          "Document",
                          textScaleFactor: textFactor,
                          style: OTPHeading11TextStyle,
                        ),
                        GestureDetector(
                          onTap: () {
                            _pickImage1();
                          },
                          child: Container(
                            height: 100.sp,
                            width: 100.sp,
                            decoration: BoxDecoration(
                              color: backgroundColor,
                            ),
                            child: Center(
                              child: (_croppedImage1 != null)
                                  ? Image.file(
                                      File(_croppedImage1!.path),
                                      width: 200.sp,
                                      height: 200.sp,
                                    )
                                  : Image.asset("assets/images/add_photo.png"),
                            ),
                          ),
                        ),
                        heightSpace20,
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10.sp,
                              bottom: 8.sp,
                              left: 20.sp,
                              right: 20.sp),
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Random random = new Random();
                                  int randomNumber = random.nextInt(100);
                                  final DateTime now = DateTime.now();
                                  final DateFormat formatter =
                                      DateFormat('yyyy-MM-dd');
                                  final String formatted =
                                      formatter.format(now);
                                  context.read<SignUpBloc>().add(SignUp1Event(
                                        File(_croppedImage!.path),
                                        randomNumber,
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
                                        File(_croppedImage1!.path),
                                      ));
                                } else {
                                  context
                                      .read<SignUpBloc>()
                                      .add(const ValidteFormEvent());
                                }
                                /*Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                );*/
                              },
                              child: Text(
                                'Request Approval',
                                style: button16TextStyle,
                                textScaleFactor: textFactor,
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0.sp),
                                )),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        primaryColor),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        horizontal: 90.sp, vertical: 15.sp)),
                              )),
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

  File? _image, _image1;
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
}
