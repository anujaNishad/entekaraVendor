import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:entekaravendor/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController storeNameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();

  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(getProportionateScreenHeight(50)),
          child: commonAppbar("Edit Profile", context)),
      body: SafeArea(
        child: Column(
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
                            CircleAvatar(
                              radius: 60.0,
                              backgroundImage:
                                  AssetImage("assets/images/vendor_image.png"),
                              backgroundColor: Colors.transparent,
                            ),
                            Positioned(
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
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(12)),
                        decoration: new InputDecoration(
                            prefixIcon: Image.asset(
                              "assets/images/OnlineStore.png",
                            ),
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
                            fillColor: textFieldColor,
                            filled: true),
                        controller: storeNameController,
                        validator: (name) {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: getProportionateScreenHeight(10),
                          bottom: getProportionateScreenHeight(8),
                          left: getProportionateScreenWidth(20),
                          right: getProportionateScreenWidth(20)),
                      child: Container(
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(5.0),
                          border: Border.all(color: Color(0xFFE1DFDD)),
                          color: textFieldColor,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Icon(Icons.phone_outlined),
                            ),
                            Expanded(
                                flex: 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    InternationalPhoneNumberInput(
                                      onInputChanged: (PhoneNumber number) {
                                        print(number.phoneNumber);
                                      },
                                      onInputValidated: (bool value) {
                                        print(value);
                                      },
                                      selectorConfig: SelectorConfig(
                                        selectorType:
                                            PhoneInputSelectorType.BOTTOM_SHEET,
                                      ),
                                      ignoreBlank: false,
                                      autoValidateMode:
                                          AutovalidateMode.disabled,
                                      selectorTextStyle:
                                          TextStyle(color: Colors.black),
                                      initialValue: number,
                                      textFieldController: phoneController,
                                      formatInput: true,
                                      inputBorder: InputBorder.none,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              signed: true, decimal: true),
                                      // inputBorder: OutlineInputBorder(),
                                      onSaved: (PhoneNumber number) {
                                        print('On Saved: $number');
                                      },
                                    ),
                                  ],
                                ))
                          ],
                        ),
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
                            prefixIcon: Image.asset(
                              "assets/images/mail.png",
                            ),
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
                            fillColor: textFieldColor,
                            filled: true),
                        controller: emailController,
                        validator: (name) {},
                      ),
                    ),
                  ],
                )),
            Expanded(
                flex: 1,
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: getProportionateScreenHeight(20)),
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Save Changes',
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
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(90),
                                vertical: getProportionateScreenHeight(15))),
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
