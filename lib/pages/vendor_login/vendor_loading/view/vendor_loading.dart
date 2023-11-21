import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/vendor_login/bloc/loading_bloc.dart';
import 'package:entekaravendor/pages/vendor_login/otp_screen/view/otp_screen.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class VendorLoadingScreen extends StatefulWidget {
  const VendorLoadingScreen({Key? key}) : super(key: key);

  @override
  State<VendorLoadingScreen> createState() => _VendorLoadingScreenState();
}

class _VendorLoadingScreenState extends State<VendorLoadingScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'IN';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is SendOtpSuccess) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OTPScreen(phoneNumber: controller.text)));
                }
              },
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Expanded(
                            flex: 8,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Center(
                                      child: Image.asset(
                                          "assets/images/logo.png")),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Image.asset(
                                      "assets/images/loading_img.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Expanded(
                            flex: 5,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                    topLeft: Radius.circular(20.0)),
                                color: primaryColor,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    getProportionateScreenHeight(16)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    heightSpace10,
                                    Text(
                                      "Enter your Mobile Number",
                                      textScaleFactor: geTextScale(),
                                      style: loadingHeadingTextStyle,
                                    ),
                                    heightSpace,
                                    Text(
                                      "Just to make sure you’re not a robot xD",
                                      textScaleFactor: geTextScale(),
                                      style: loadingHeading14TextStyle,
                                    ),
                                    heightSpace20,
                                    Form(
                                      key: formKey,
                                      child: IntlPhoneField(
                                        controller: controller,
                                        decoration: InputDecoration(
                                            prefixIconColor: Colors.black,
                                            prefixIcon: Icon(
                                              Icons.phone_outlined,
                                              color: Colors.black,
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                            labelText: 'Phone Number',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              borderSide: BorderSide(
                                                  color: Color(0xFFE1DFDD),
                                                  width: 1),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              borderSide: BorderSide(
                                                  color: Color(0xFFE1DFDD),
                                                  width: 1),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.blue))),
                                        initialCountryCode: 'IN',
                                        onChanged: (phone) {
                                          print(phone.completeNumber);
                                        },
                                      ),
                                    ),
                                    heightSpace30,
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          String phno = controller.text;
                                          String phno1 =
                                              phno.replaceAll(" ", "");
                                          if (formKey.currentState!
                                              .validate()) {
                                            context.read<LoginBloc>().add(
                                                UserLoginEvent(
                                                    int.parse(phno1)));
                                          } else {
                                            context
                                                .read<LoginBloc>()
                                                .add(ValidteFormEvent());
                                          }
                                        },
                                        child: state.isFetching
                                            ? loadingText()
                                            : loginText(),
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0.sp),
                                          )),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  backgroundColor),
                                          padding: MaterialStateProperty
                                              .all<EdgeInsets>(EdgeInsets.only(
                                                  left:
                                                      getProportionateScreenWidth(
                                                          150),
                                                  right:
                                                      getProportionateScreenWidth(
                                                          150),
                                                  top:
                                                      getProportionateScreenHeight(
                                                          15),
                                                  bottom:
                                                      getProportionateScreenHeight(
                                                          15))),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ))
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

  loginText() {
    return Text(
      'Next',
      style: button16TextStyle,
      textScaleFactor: textFactor,
    );
  }

  loadingText() {
    return SizedBox(
        height: getProportionateScreenHeight(15),
        width: getProportionateScreenWidth(15),
        child: CircularProgressIndicator());
  }
}
