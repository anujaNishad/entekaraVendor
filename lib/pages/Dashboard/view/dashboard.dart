import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/model/homemodel.dart';
import 'package:entekaravendor/pages/add_product/bloc/product_bloc.dart';
import 'package:entekaravendor/pages/category/view/category_details_new.dart';
import 'package:entekaravendor/pages/product/view/product_details.dart';
import 'package:entekaravendor/pages/vendor_login/vendor_loading/view/vendor_loading.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  int vendorId = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vendorId = int.parse(storage.read("vendorId").toString());
    initializedata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => ProductBloc()..add(FetchProductItem(vendorId, "")),
      child: SafeArea(
        child: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {},
          child:
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
            if (state is ErrorState) {
              print("state.err=${state.error}");
              if (state.error == "Vendor is not accepted by admin") {
                return Padding(
                  padding:
                      EdgeInsets.only(top: getProportionateScreenHeight(280)),
                  child: Column(
                    children: [
                      Center(child: Text(state.error)),
                      Padding(
                        padding: EdgeInsets.only(
                            top: getProportionateScreenHeight(10),
                            bottom: getProportionateScreenHeight(8),
                            left: getProportionateScreenWidth(20),
                            right: getProportionateScreenWidth(20)),
                        child: ElevatedButton(
                            onPressed: () {
                              storage.remove("token");
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        VendorLoadingScreen()),
                              );
                            },
                            child: Text(
                              'Logout',
                              style: button16TextStyle,
                              textScaleFactor: textFactor,
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0.sp),
                              )),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  primaryColor),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(90),
                                      vertical:
                                          getProportionateScreenHeight(15))),
                            )),
                      ),
                    ],
                  ),
                );
              } else {
                return getDashboardData();
              }
            } else {
              return getDashboardData();
            }
          }),
        ),
      ),
    ));
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
      height: getProportionateScreenHeight(150),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductDetails(
                            isBack: true,
                          )));
            },
            child: Container(
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(10),
                  right: getProportionateScreenWidth(10)),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(getProportionateScreenHeight(16)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                      builder: (context) => const CategoryDetailsNew()));
            },
            child: Container(
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(10),
                  right: getProportionateScreenWidth(10)),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(getProportionateScreenHeight(16)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: greyColor),
                    ),
                    child: Image.asset(
                      "assets/images/category.png",
                      height: getProportionateScreenHeight(70),
                      width: getProportionateScreenWidth(70),
                    ),
                  ),
                  heightSpace10,
                  Text(
                    'Category',
                    style: Text10pTextStyle,
                    textScaleFactor: geTextScale(),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: getProportionateScreenWidth(10),
                right: getProportionateScreenWidth(10)),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(getProportionateScreenHeight(16)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
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
            padding: EdgeInsets.only(
                left: getProportionateScreenWidth(10),
                right: getProportionateScreenWidth(10)),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(getProportionateScreenHeight(16)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: greyColor),
                  ),
                  child: Image.asset("assets/images/Discount.png"),
                ),
                heightSpace10,
                Text(
                  'Best Deals',
                  style: Text10pTextStyle,
                  textScaleFactor: geTextScale(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getDashboardData() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenHeight(16)),
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
                            textScaleFactor: geTextScale(),
                          ),
                          Text(
                            '${storage.read("mobile")}',
                            style: Text10pTextStyle,
                            textScaleFactor: geTextScale(),
                          ),
                          /*Row(
                            children: [
                              Text(
                                'Open Now',
                                style: Text10pTextStyle,
                                textScaleFactor: geTextScale(),
                              ),
                              widthSpace10,
                              Text(
                                'Edit Timings',
                                style: Text8pTextStyle,
                                textScaleFactor: geTextScale(),
                              ),
                            ],
                          )*/
                        ],
                      ),
                    )),
                Expanded(
                  flex: 1,
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage:
                        NetworkImage("${storage.read("thumbnail")}"),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
            heightSpace40,
            /* Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: getProportionateScreenHeight(40),
                      width: getProportionateScreenWidth(40),
                    )),
                Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Request is still under review",
                          textScaleFactor: geTextScale(),
                          style: OTPHeading145TextStyle,
                        ),
                        Text(
                          "Check request status",
                          textScaleFactor: geTextScale(),
                          style: OTPHeading11TextStyle,
                        ),
                      ],
                    )),
                Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios)),
              ],
            ),
            heightSpace40,*/
            getOption(),
            heightSpace20,
            Container(
              height: getProportionateScreenHeight(300),
              width: getProportionateScreenWidth(400),
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
                padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(100),
                    right: getProportionateScreenWidth(50),
                    top: getProportionateScreenHeight(20)),
                child: Text(
                  "Advertisement",
                  style: loadingHeadingTextStyle,
                  textScaleFactor: geTextScale(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
