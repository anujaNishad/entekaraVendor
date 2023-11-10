import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/model/homemodel.dart';
import 'package:entekaravendor/pages/category/view/category_details.dart';
import 'package:entekaravendor/pages/product/view/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class DashboardDetails extends StatefulWidget {
  const DashboardDetails({Key? key}) : super(key: key);

  @override
  State<DashboardDetails> createState() => _DashboardDetailsState();
}

class _DashboardDetailsState extends State<DashboardDetails> {
  List<dynamic> homeList = [];
  final storage = GetStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializedata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 4,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${storage.read("vendorName")}',
                                style: Text24pTextStyle,
                                textScaleFactor: textFactor,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Open Now',
                                    style: Text10pTextStyle,
                                    textScaleFactor: textFactor,
                                  ),
                                  widthSpace10,
                                  Text(
                                    'Edit Timings',
                                    style: Text8pTextStyle,
                                    textScaleFactor: textFactor,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                    Expanded(flex: 1, child: Icon(Icons.account_circle)),
                  ],
                ),
                heightSpace40,
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Image.asset(
                          "assets/images/logo.png",
                          height: 40.sp,
                          width: 40.sp,
                        )),
                    Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Request is still under review",
                              textScaleFactor: textFactor,
                              style: OTPHeading145TextStyle,
                            ),
                            Text(
                              "Check request status",
                              textScaleFactor: textFactor,
                              style: OTPHeading11TextStyle,
                            ),
                          ],
                        )),
                    Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios)),
                  ],
                ),
                heightSpace40,
                getOption(),
                heightSpace20,
                Container(
                  height: 300.sp,
                  width: 400.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                    ),
                    color: Colors.grey,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 60.sp, right: 20.sp, top: 20.sp),
                    child: Text(
                      "Item In Demands",
                      style: loadingHeadingTextStyle,
                      textScaleFactor: textFactor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void initializedata() {
    homeModel h1 =
        homeModel(image: "assets/images/VegetablesBox.png", name: "Products");
    homeModel h2 = homeModel(image: "assets/images/cart.png", name: "Orders");
    homeModel h3 =
        homeModel(image: "assets/images/Discount.png", name: "Best Deals");
    homeList.addAll([h1, h2, h3]);
  }

  Widget getOption() {
    return Container(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductDetails()));
            },
            child: Container(
              padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(color: greyColor),
                    ),
                    child: Image.asset("assets/images/VegetablesBox.png"),
                  ),
                  heightSpace10,
                  Text(
                    'Product',
                    style: Text10pTextStyle,
                    textScaleFactor: textFactor,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CategoryDetails()));
            },
            child: Container(
              padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(color: greyColor),
                    ),
                    child: Image.asset(
                      "assets/images/category.png",
                      height: 70.sp,
                      width: 70.sp,
                    ),
                  ),
                  heightSpace10,
                  Text(
                    'Category',
                    style: Text10pTextStyle,
                    textScaleFactor: textFactor,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    border: Border.all(color: greyColor),
                  ),
                  child: Image.asset("assets/images/cart.png"),
                ),
                heightSpace10,
                Text(
                  'Orders',
                  style: Text10pTextStyle,
                  textScaleFactor: textFactor,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    border: Border.all(color: greyColor),
                  ),
                  child: Image.asset("assets/images/Discount.png"),
                ),
                heightSpace10,
                Text(
                  'Best Deals',
                  style: Text10pTextStyle,
                  textScaleFactor: textFactor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
