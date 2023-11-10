import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

SizedBox heightSpace = SizedBox(height: 5.sp);
SizedBox heightSpace10 = SizedBox(height: 10.sp);
SizedBox heightSpace20 = SizedBox(height: 20.sp);
SizedBox widthSpace = SizedBox(width: 5.sp);
SizedBox widthSpace10 = SizedBox(width: 10.sp);
SizedBox widthSpace20 = SizedBox(width: 20.sp);
SizedBox widthSpace40 = SizedBox(width: 40.sp);
SizedBox widthSpace2 = SizedBox(width: 2.sp);
SizedBox heightSpace30 = SizedBox(height: 30.sp);
SizedBox heightSpace40 = SizedBox(height: 40.sp);
SizedBox heightSpace60 = SizedBox(height: 60.sp);
SizedBox heightSpace80 = SizedBox(height: 80.sp);
const double fixPadding = 10;

TextStyle loadingHeadingTextStyle = TextStyle(
  color: backgroundColor,
  fontSize: 20.sp,
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins",
);
TextStyle heading18TextStyle = TextStyle(
  color: backgroundColor,
  fontSize: 18.sp,
  fontWeight: FontWeight.w600,
  fontFamily: "Poppins",
);
TextStyle OTPHeading14TextStyle = TextStyle(
  color: backgroundColor,
  fontSize: 14.sp,
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);
TextStyle OTPHeading145TextStyle = TextStyle(
  color: backgroundColor,
  fontSize: 14.sp,
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins",
);
TextStyle OTPHeading11TextStyle = TextStyle(
  color: backgroundColor,
  fontSize: 11.sp,
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);

TextStyle change14TextStyle = TextStyle(
  color: changepwdColor,
  fontSize: 14.sp,
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);
TextStyle second16TextStyle = TextStyle(
  color: secondTextColor,
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins",
);
TextStyle second14TextStyle = TextStyle(
  color: secondTextColor,
  fontSize: 14.sp,
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);
TextStyle loadingHeading14TextStyle = TextStyle(
  color: secondColor,
  fontSize: 14.sp,
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);
TextStyle button16TextStyle = TextStyle(
  color: textColor,
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins",
);
TextStyle button16BTextStyle = TextStyle(
  color: backgroundColor,
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins",
);
TextStyle Text12TextStyle = TextStyle(
  color: Colors.black,
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);
TextStyle Text12bTextStyle = TextStyle(
  color: backgroundColor,
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);
TextStyle Text9TextStyle = TextStyle(
  color: Colors.black,
  fontSize: 9.sp,
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);
TextStyle Text8pTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 8.sp,
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins",
);
TextStyle Text8NTextStyle = TextStyle(
  color: backgroundColor,
  fontSize: 8.sp,
  fontWeight: FontWeight.w300,
  fontFamily: "Poppins",
);
TextStyle Text10pTextStyle = TextStyle(
  color: backgroundColor,
  fontSize: 10.sp,
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins",
);
TextStyle Text10STextStyle = TextStyle(
  color: secondColor,
  fontSize: 10.sp,
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);
TextStyle Text24pTextStyle = TextStyle(
  color: backgroundColor,
  fontSize: 24.sp,
  fontWeight: FontWeight.w600,
  fontFamily: "Poppins",
);
TextStyle Text24STextStyle = TextStyle(
  color: backgroundColor,
  fontSize: 24.sp,
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);
TextStyle appbarTextStyle = TextStyle(
  color: backgroundColor,
  fontSize: 20.sp,
  fontWeight: FontWeight.w600,
  fontFamily: "Poppins",
);
TextStyle bold16TextStyle = TextStyle(
  color: secondColor,
  fontSize: 16.sp,
  fontWeight: FontWeight.w700,
  fontFamily: "Poppins",
);
TextStyle Product16TextStyle = TextStyle(
  color: backgroundColor,
  fontSize: 16.sp,
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);
TextStyle grey15RegularTextStyle = const TextStyle(
  color: Colors.grey,
  fontSize: 15,
  fontWeight: FontWeight.w400,
);
TextStyle black14SemiBoldTextStyle = const TextStyle(
  color: blackColor,
  fontSize: 14,
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
