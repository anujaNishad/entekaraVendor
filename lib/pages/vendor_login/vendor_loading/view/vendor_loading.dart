import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/vendor_login/bloc/loading_bloc.dart';
import 'package:entekaravendor/pages/vendor_login/otp_screen/view/otp_screen.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is SendOtpSuccess) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OTPScreen(phoneNumber: controller.text)));
                } else if (state is ErrorState) {
                  print("xsbsdhj");
                }
              },
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //heightSpace80,
                            Expanded(
                              flex: 4,
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: SvgPicture.asset(
                                    "assets/images/e_logo.svg"),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                alignment: Alignment.topCenter,
                                child: Center(
                                    child: SvgPicture.asset(
                                  "assets/images/e_login.svg",
                                  fit: BoxFit.cover,
                                )),
                              ),
                            ),
                            Expanded(flex: 3, child: Container())
                          ],
                        ),
                        Positioned(
                          bottom: 0,
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
                                    style: Text10STextStyle,
                                  ),
                                  heightSpace20,
                                  Form(
                                    key: formKey,
                                    child: IntlPhoneField(
                                      controller: controller,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 5.0, 20.0, 5.0),
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
                                                  color: Color(0xFFE1DFDD)))),
                                      initialCountryCode: 'IN',
                                      onChanged: (phone) {
                                        print(phone.completeNumber);
                                      },
                                    ),
                                  ),
                                  heightSpace30,
                                  Center(
                                    child: GestureDetector(
                                      onTap: () {
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
                                      child: Container(
                                        height:
                                            getProportionateScreenHeight(30),
                                        width: getProportionateScreenWidth(182),
                                        padding: EdgeInsets.only(
                                          left: getProportionateScreenWidth(75),
                                          top: getProportionateScreenHeight(5),
                                          right:
                                              getProportionateScreenWidth(75),
                                          bottom:
                                              getProportionateScreenHeight(5),
                                        ),
                                        decoration: BoxDecoration(
                                            color: backgroundColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: state.isFetching
                                            ? loadingText()
                                            : loginText(),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
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
      style: Text12TextTextStyle,
      textScaleFactor: textFactor,
    );
  }

  loadingText() {
    return SpinKitThreeBounce(
      color: Colors.white,
      size: getProportionateScreenHeight(10),
    );

    /* SizedBox(
        height: getProportionateScreenHeight(5),
        width: getProportionateScreenWidth(5),
        child: Center(child: CircularProgressIndicator()));*/
  }
}
