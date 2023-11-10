import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/Dashboard/view/home_screen.dart';
import 'package:entekaravendor/pages/location_details/view/location_details.dart';
import 'package:entekaravendor/pages/vendor_login/bloc/loading_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key, this.phoneNumber}) : super(key: key);
  final String? phoneNumber;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int otpCode = 0;
  @override
  Widget build(BuildContext context) {
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
                        builder: (context) => const LocationDetails()));
              } else if (state.logindata!.data!.existing == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              }
            } else if (state is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.black,
                content: const Text("OTP or Mobile Number Mismatch"),
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60.sp,
                  ),
                  Center(child: Image.asset("assets/images/otp_img.png")),
                  SizedBox(
                    height: 60.sp,
                  ),
                  Center(child: Image.asset("assets/images/verify_otp.png")),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0.sp, right: 16.0.sp),
                    child: Text(
                      "Enter Verification Code",
                      textScaleFactor: textFactor,
                      style: loadingHeadingTextStyle,
                    ),
                  ),
                  heightSpace10,
                  Padding(
                    padding: EdgeInsets.only(left: 16.0.sp, right: 16.0.sp),
                    child: Text(
                      "We have sent an SMS to:",
                      textScaleFactor: textFactor,
                      style: loadingHeading14TextStyle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0.sp, right: 16.0.sp),
                    child: Text(
                      "+91 ${widget.phoneNumber}",
                      textScaleFactor: textFactor,
                      style: bold16TextStyle,
                    ),
                  ),
                  heightSpace30,
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0)),
                      color: primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          heightSpace20,
                          Form(
                            key: formKey,
                            child: OtpTextField(
                              numberOfFields: 6,
                              filled: true,
                              fieldWidth: 45.0.sp,
                              fillColor: textFieldColor,
                              styles: [],
                              showFieldAsBox: true,
                              borderWidth: 1.0,
                              onCodeChanged: (String code) {},
                              onSubmit: (String verificationCode) {
                                print("ver=$verificationCode");

                                setState(() {
                                  otpCode = int.parse(verificationCode);
                                });
                              },
                            ),
                          ),
                          heightSpace30,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Resend OTP",
                                textScaleFactor: textFactor,
                                style: OTPHeading14TextStyle,
                              ),
                              Text(
                                "Change Phone Number",
                                textScaleFactor: textFactor,
                                style: change14TextStyle,
                              ),
                            ],
                          ),
                          heightSpace30,
                          ElevatedButton(
                              onPressed: () {
                                String phno1 =
                                    widget.phoneNumber!.replaceAll(" ", "");
                                print("gfgfg=$phno1");
                                print("frfjh=$otpCode");
                                if (formKey.currentState!.validate()) {
                                  context.read<LoginBloc>().add(VerifyOtpEvent(
                                      otpCode, int.parse(phno1)));
                                } else {
                                  context
                                      .read<LoginBloc>()
                                      .add(ValidteFormEvent());
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
                                  borderRadius: BorderRadius.circular(8.0.sp),
                                )),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        backgroundColor),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        horizontal: 137.sp, vertical: 15.sp)),
                              )),
                          heightSpace60
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      )),
    ));
  }
}
