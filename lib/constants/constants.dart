import 'package:entekaravendor/util/size_config.dart';
import 'package:flutter/material.dart';

double textFactor = 0.9;
String googleAPIKey = "AIzaSyCrpkGoBrRGNN2Vkaa9tDD-E2KkGlHd8sw";

const Color primaryColor = Color(0xff16D59F);

const Color whiteColor = Colors.white;
const Color blackColor = Colors.black;
const Color greyColor = Color(0xFFC4C4C4);
const Color backgroundColor = Color(0xFF002434);
const Color secondColor = Color(0xFF1F3F4D);
const Color textColor = Color(0xFFFBFCFE);
const Color textFieldColor = Color(0xFFF0F1F2);
const Color changepwdColor = Color(0xFF1F3F4D);
const Color redColor = Color(0xFF9B0808);
const Color orangeColor = Color(0xFFF37A20);
const Color secondTextColor = Color(0xFF37474F);

SizedBox heightSpace = SizedBox(height: getProportionateScreenHeight(5));
SizedBox heightSpace10 = SizedBox(height: getProportionateScreenHeight(10));
SizedBox heightSpace20 = SizedBox(height: getProportionateScreenHeight(20));
SizedBox widthSpace = SizedBox(width: getProportionateScreenWidth(5));
SizedBox widthSpace10 = SizedBox(width: getProportionateScreenWidth(10));
SizedBox widthSpace20 = SizedBox(width: getProportionateScreenWidth(20));
SizedBox widthSpace40 = SizedBox(width: getProportionateScreenWidth(40));
SizedBox widthSpace2 = SizedBox(width: getProportionateScreenWidth(2));
SizedBox heightSpace30 = SizedBox(height: getProportionateScreenHeight(30));
SizedBox heightSpace40 = SizedBox(height: getProportionateScreenHeight(40));
SizedBox heightSpace60 = SizedBox(height: (getProportionateScreenHeight(60)));
SizedBox heightSpace70 = SizedBox(height: getProportionateScreenHeight(70));
SizedBox heightSpace80 = SizedBox(height: getProportionateScreenHeight(80));
const double fixPadding = 10;

TextStyle loadingHeadingTextStyle = TextStyle(
  color: backgroundColor,
  fontSize: getProportionateScreenHeight(20),
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins",
);
TextStyle heading18TextStyle = TextStyle(
  color: backgroundColor,
  fontSize: getProportionateScreenHeight(18),
  fontWeight: FontWeight.w600,
  fontFamily: "Poppins",
);
TextStyle heading18PrimaryTextStyle = TextStyle(
  color: primaryColor,
  fontSize: getProportionateScreenHeight(18),
  fontWeight: FontWeight.w600,
  fontFamily: "Poppins",
);
TextStyle OTPHeading14TextStyle = TextStyle(
  color: backgroundColor,
  fontSize: getProportionateScreenHeight(14),
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);
TextStyle OTPHeading145TextStyle = TextStyle(
  color: backgroundColor,
  fontSize: getProportionateScreenHeight(14),
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins",
);
TextStyle OTPHeading11TextStyle = TextStyle(
  color: backgroundColor,
  fontSize: getProportionateScreenHeight(11),
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);

TextStyle change14TextStyle = TextStyle(
  color: changepwdColor,
  fontSize: getProportionateScreenHeight(14),
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);
TextStyle second16TextStyle = TextStyle(
  color: secondTextColor,
  fontSize: getProportionateScreenHeight(16),
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins",
);
TextStyle second14TextStyle = TextStyle(
  color: secondTextColor,
  fontSize: getProportionateScreenHeight(14),
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);
TextStyle loadingHeading14TextStyle = TextStyle(
  color: secondColor,
  fontSize: getProportionateScreenHeight(14),
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);
TextStyle button16TextStyle = TextStyle(
  color: textColor,
  fontSize: getProportionateScreenHeight(16),
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins",
);
TextStyle button16BTextStyle = TextStyle(
  color: backgroundColor,
  fontSize: getProportionateScreenHeight(16),
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins",
);
TextStyle Text12TextStyle = TextStyle(
  color: Colors.black,
  fontSize: getProportionateScreenHeight(12),
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);
TextStyle Text12bTextStyle = TextStyle(
  color: backgroundColor,
  fontSize: getProportionateScreenHeight(12),
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);
TextStyle Text9TextStyle = TextStyle(
  color: Colors.black,
  fontSize: getProportionateScreenHeight(9),
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);
TextStyle Text8pTextStyle = TextStyle(
  color: primaryColor,
  fontSize: getProportionateScreenHeight(8),
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins",
);
TextStyle Text8NTextStyle = TextStyle(
  color: backgroundColor,
  fontSize: getProportionateScreenHeight(8),
  fontWeight: FontWeight.w300,
  fontFamily: "Poppins",
);
TextStyle Text10pTextStyle = TextStyle(
  color: backgroundColor,
  fontSize: getProportionateScreenHeight(10),
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins",
);
TextStyle Text10STextStyle = TextStyle(
  color: secondColor,
  fontSize: getProportionateScreenHeight(10),
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);
TextStyle Text24pTextStyle = TextStyle(
  color: backgroundColor,
  fontSize: getProportionateScreenHeight(24),
  fontWeight: FontWeight.w600,
  fontFamily: "Poppins",
);
TextStyle Text24STextStyle = TextStyle(
  color: backgroundColor,
  fontSize: getProportionateScreenHeight(24),
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);
TextStyle appbarTextStyle = TextStyle(
  color: backgroundColor,
  fontSize: getProportionateScreenHeight(20),
  fontWeight: FontWeight.w600,
  fontFamily: "Poppins",
);
TextStyle bold16TextStyle = TextStyle(
  color: secondColor,
  fontSize: getProportionateScreenHeight(16),
  fontWeight: FontWeight.w700,
  fontFamily: "Poppins",
);
TextStyle Product16TextStyle = TextStyle(
  color: backgroundColor,
  fontSize: getProportionateScreenHeight(16),
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);
TextStyle grey15RegularTextStyle = TextStyle(
  color: Colors.grey,
  fontSize: getProportionateScreenHeight(15),
  fontWeight: FontWeight.w400,
);
TextStyle black14SemiBoldTextStyle = TextStyle(
  color: blackColor,
  fontSize: getProportionateScreenHeight(14),
  fontWeight: FontWeight.w600,
);

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
    BuildContext context, String data) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(data),
  ));
}

class ErrorImage extends StatelessWidget {
  const ErrorImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: primaryColor,
        image: DecorationImage(
            fit: BoxFit.contain, image: AssetImage('assets/logonew.png')),
      ),
    );
  }
}

List<dynamic> colorList = [
  Colors.greenAccent,
  Colors.pinkAccent,
  Colors.blueAccent,
  Colors.amberAccent,
  Colors.deepPurpleAccent,
  Colors.orangeAccent
];
