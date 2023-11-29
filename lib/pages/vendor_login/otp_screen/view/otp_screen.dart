import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/Dashboard/view/home_screen.dart';
import 'package:entekaravendor/pages/location_details/view/location_details.dart';
import 'package:entekaravendor/pages/vendor_login/bloc/loading_bloc.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key, this.phoneNumber}) : super(key: key);
  final String? phoneNumber;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final focusNode = FocusNode();
  TextEditingController pinController = TextEditingController();

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
                              phoneNumber: widget.phoneNumber,
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
                              child: Image.asset(
                                "assets/images/otpimg.png",
                              ),
                            ),
                            // heightSpace40,
                            Center(
                              child: SvgPicture.asset(
                                "assets/images/otp_bg.svg",
                                height: 300,
                              ),
                            ),
                            // heightSpace30,
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
                            //heightSpace10,
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
                                  child: Pinput(
                                    controller: pinController,
                                    length: 6,
                                    focusNode: focusNode,
                                    defaultPinTheme: _defaultPinTheme,
                                    onCompleted: (pin) {
                                      setState(() {
                                        print("pin=$pin");
                                        otpCode = int.parse(pin);
                                      });
                                    },
                                  ),
                                ),
                                heightSpace10,
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
                                  child: GestureDetector(
                                    onTap: () {
                                      String phno1 = widget.phoneNumber!
                                          .replaceAll(" ", "");

                                      if (formKey.currentState!.validate()) {
                                        context.read<LoginBloc>().add(
                                            VerifyOtpEvent(
                                                otpCode, int.parse(phno1)));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text("All field required"),
                                          duration: const Duration(seconds: 2),
                                          action: SnackBarAction(
                                            label: 'OK',
                                            onPressed: () {},
                                          ),
                                        ));
                                      }
                                    },
                                    child: Container(
                                      height: getProportionateScreenHeight(30),
                                      width: getProportionateScreenWidth(182),
                                      padding: EdgeInsets.only(
                                        left: getProportionateScreenWidth(75),
                                        top: getProportionateScreenHeight(5),
                                        right: getProportionateScreenWidth(75),
                                        bottom: getProportionateScreenHeight(5),
                                      ),
                                      decoration: BoxDecoration(
                                          color: backgroundColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: state.isFetching
                                          ? loadingText()
                                          : Center(
                                              child: Text(
                                                'Next',
                                                style: button16TextStyle,
                                                textScaleFactor: textFactor,
                                              ),
                                            ),
                                    ),
                                  ),
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

  loadingText() {
    return SizedBox(
        height: getProportionateScreenHeight(10),
        width: getProportionateScreenWidth(10),
        child: Center(child: CircularProgressIndicator()));
  }

  var _defaultPinTheme = PinTheme(
    height: getProportionateScreenHeight(56),
    width: getProportionateScreenWidth(56),
    textStyle: TextStyle(
        fontSize: getProportionateScreenHeight(16),
        color: Colors.black,
        fontWeight: FontWeight.w400),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    ),
  );
}
