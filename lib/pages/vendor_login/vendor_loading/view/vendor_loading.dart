import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/vendor_login/bloc/loading_bloc.dart';
import 'package:entekaravendor/pages/vendor_login/otp_screen/view/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class VendorLoadingScreen extends StatefulWidget {
  const VendorLoadingScreen({Key? key}) : super(key: key);

  @override
  State<VendorLoadingScreen> createState() => _VendorLoadingScreenState();
}

class _VendorLoadingScreenState extends State<VendorLoadingScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
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
                  return Column(
                    children: [
                      SizedBox(
                        height: 60.sp,
                      ),
                      Center(child: Image.asset("assets/images/logo.png")),
                      SizedBox(
                        height: 60.sp,
                      ),
                      Center(
                          child: Image.asset("assets/images/loading_img.png")),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              topLeft: Radius.circular(20.0)),
                          color: primaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              heightSpace10,
                              Text(
                                "Enter your Mobile Number",
                                textScaleFactor: textFactor,
                                style: loadingHeadingTextStyle,
                              ),
                              heightSpace,
                              Text(
                                "Just to make sure you’re not a robot xD",
                                textScaleFactor: textFactor,
                                style: loadingHeading14TextStyle,
                              ),
                              heightSpace20,
                              Form(
                                key: formKey,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 10.sp, right: 10.sp),
                                  decoration: new BoxDecoration(
                                    borderRadius:
                                        new BorderRadius.circular(16.0),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              InternationalPhoneNumberInput(
                                                onInputChanged:
                                                    (PhoneNumber number) {
                                                  print(
                                                      "phno=${number.phoneNumber!.replaceRange(0, 3, "")}");
                                                },
                                                onInputValidated: (bool value) {
                                                  print(value);
                                                },
                                                selectorConfig: SelectorConfig(
                                                  selectorType:
                                                      PhoneInputSelectorType
                                                          .BOTTOM_SHEET,
                                                ),
                                                ignoreBlank: false,
                                                autoValidateMode:
                                                    AutovalidateMode.disabled,
                                                selectorTextStyle: TextStyle(
                                                    color: Colors.black),
                                                initialValue: number,
                                                textFieldController: controller,
                                                formatInput: true,
                                                inputBorder: InputBorder.none,
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        signed: true,
                                                        decimal: true),
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
                              heightSpace40,
                              ElevatedButton(
                                  onPressed: () {
                                    String phno = controller.text;
                                    String phno1 = phno.replaceAll(" ", "");
                                    if (formKey.currentState!.validate()) {
                                      context.read<LoginBloc>().add(
                                          UserLoginEvent(int.parse(phno1)));
                                    } else {
                                      context
                                          .read<LoginBloc>()
                                          .add(ValidteFormEvent());
                                    }
                                  },
                                  child: state.isFetching
                                      ? CircularProgressIndicator()
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
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.symmetric(
                                                horizontal: 145.sp,
                                                vertical: 15.sp)),
                                  )),
                              heightSpace30
                            ],
                          ),
                        ),
                      )
                    ],
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
}
