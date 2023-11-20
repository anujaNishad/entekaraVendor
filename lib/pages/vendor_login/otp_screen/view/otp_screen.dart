import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/Dashboard/view/home_screen.dart';
import 'package:entekaravendor/pages/location_details/view/location_details.dart';
import 'package:entekaravendor/pages/vendor_login/bloc/loading_bloc.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key, this.phoneNumber}) : super(key: key);
  final String? phoneNumber;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();

  int otpCode = 0;
  double? height;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: BlocProvider(
      create: (context) => LoginBloc(),
      child: SafeArea(
          child: SingleChildScrollView(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoadedState) {
              if (state.logindata!.data!.existing == 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LocationDetails(
                              userId: state.logindata!.data!.id,
                            )));
              } else if (state.logindata!.data!.existing == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              }
            } else if (state is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.black,
                content: Container(
                    height: getProportionateScreenHeight(40),
                    child: Text("OTP or Mobile Number Mismatch")),
                duration: const Duration(seconds: 4),
                action: SnackBarAction(
                  label: '',
                  onPressed: () {},
                ),
              ));
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heightSpace70,
                            Center(
                                child:
                                    Image.asset("assets/images/otp_img.png")),
                            heightSpace40,
                            Center(
                                child: Image.asset(
                                    "assets/images/verify_otp.png")),
                            heightSpace30,
                            Padding(
                              padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(16),
                                  right: getProportionateScreenWidth(16)),
                              child: Text(
                                "Enter Verification Code",
                                textScaleFactor: geTextScale(),
                                style: loadingHeadingTextStyle,
                              ),
                            ),
                            heightSpace10,
                            Padding(
                              padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(16),
                                  right: getProportionateScreenWidth(16)),
                              child: Text(
                                "We have sent an SMS to:",
                                textScaleFactor: geTextScale(),
                                style: loadingHeading14TextStyle,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(16),
                                  right: getProportionateScreenWidth(16)),
                              child: Text(
                                "+91 ${widget.phoneNumber}",
                                textScaleFactor: geTextScale(),
                                style: bold16TextStyle,
                              ),
                            ),
                          ],
                        )),
                    Expanded(
                        flex: 4,
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
                                getProportionateScreenHeight(24)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                heightSpace20,
                                Form(
                                  key: formKey,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _textFieldOTP(
                                          first: true,
                                          last: false,
                                          controllerr: controller1),
                                      _textFieldOTP(
                                          first: false,
                                          last: false,
                                          controllerr: controller2),
                                      _textFieldOTP(
                                          first: false,
                                          last: false,
                                          controllerr: controller3),
                                      _textFieldOTP(
                                          first: false,
                                          last: false,
                                          controllerr: controller4),
                                      _textFieldOTP(
                                          first: false,
                                          last: false,
                                          controllerr: controller5),
                                      _textFieldOTP(
                                          first: false,
                                          last: true,
                                          controllerr: controller6),
                                    ],
                                  ),
                                  /*OtpTextField(
                                    numberOfFields: 6,
                                    filled: true,
                                    fieldWidth: getProportionateScreenWidth(45),
                                    fillColor: textFieldColor,
                                    styles: [],
                                    showFieldAsBox: true,
                                    clearText: true,
                                    borderWidth: 1.0,
                                    onCodeChanged: (String code) {},
                                    onSubmit: (String verificationCode) {
                                      print("ver=$verificationCode");

                                      setState(() {
                                        otpCode = int.parse(verificationCode);
                                      });
                                    },
                                  )*/
                                ),
                                // heightSpace20,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Resend OTP",
                                      textScaleFactor: geTextScale(),
                                      style: OTPHeading14TextStyle,
                                    ),
                                    Text(
                                      "Change Phone Number",
                                      textScaleFactor: geTextScale(),
                                      style: change14TextStyle,
                                    ),
                                  ],
                                ),
                                heightSpace40,
                                Center(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        String phno1 = widget.phoneNumber!
                                            .replaceAll(" ", "");
                                        print("gfgfg=$phno1");
                                        int otpValue = 0;
                                        String otp = (controller1.text +
                                                controller2.text +
                                                controller3.text +
                                                controller4.text +
                                                controller5.text +
                                                controller6.text)
                                            .trim();
                                        //otpValue = int.parse(otp.toString());
                                        if (otp != "") {
                                          otpValue = int.parse(otp.toString());
                                        } else {
                                          otpValue = 0;
                                        }
                                        print("frfjh=$otpValue");
                                        if (controller1.text != "" &&
                                            controller2.text != "" &&
                                            controller3.text != "" &&
                                            controller4.text != "" &&
                                            controller5.text != "" &&
                                            controller6.text != "") {
                                          context.read<LoginBloc>().add(
                                              VerifyOtpEvent(
                                                  otpValue, int.parse(phno1)));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text("All field required"),
                                            duration:
                                                const Duration(seconds: 2),
                                            action: SnackBarAction(
                                              label: 'OK',
                                              onPressed: () {},
                                            ),
                                          ));
                                        }
                                      },
                                      child: state.isFetching
                                          ? CircularProgressIndicator()
                                          : Text(
                                              'Next',
                                              style: button16TextStyle,
                                              textScaleFactor: textFactor,
                                            ),
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
                                                        140),
                                                right:
                                                    getProportionateScreenWidth(
                                                        140),
                                                top:
                                                    getProportionateScreenHeight(
                                                        15),
                                                bottom:
                                                    getProportionateScreenHeight(
                                                        15))),
                                      )),
                                ),
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
      )),
    ));
  }

  Widget _textFieldOTP(
      {bool? first, last, TextEditingController? controllerr}) {
    return Container(
      height: getProportionateScreenHeight(70),
      width: getProportionateScreenWidth(50),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          controller: controllerr,
          autofocus: true,
          onChanged: (value) {
            print("value=$value");
            print("value length=${value.length}");
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              print("value st=trur");
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: true,
          readOnly: false,
          textAlign: TextAlign.center,
          cursorColor: primaryColor,
          style: TextStyle(
              fontSize: getProportionateScreenHeight(16),
              fontWeight: FontWeight.normal),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(12)),
            contentPadding:
                EdgeInsets.only(bottom: 15.0, left: 10.0, right: 10.0),
          ),
        ),
      ),
    );
  }
}
