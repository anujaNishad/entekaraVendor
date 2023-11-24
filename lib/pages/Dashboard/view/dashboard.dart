import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/add_product/bloc/product_bloc.dart';
import 'package:entekaravendor/pages/category/view/your_category.dart';
import 'package:entekaravendor/pages/product/view/product_details.dart';
import 'package:entekaravendor/pages/vendor_login/vendor_loading/view/vendor_loading.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: Text(state.error)),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          storage.remove("token");
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VendorLoadingScreen()),
                          );
                        },
                        child: Container(
                          height: getProportionateScreenHeight(30),
                          width: getProportionateScreenWidth(182),
                          padding: EdgeInsets.only(
                            // left: getProportionateScreenWidth(10),
                            top: getProportionateScreenHeight(5),
                            // right: getProportionateScreenWidth(10),
                            bottom: getProportionateScreenHeight(5),
                          ),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: Text(
                              'Logout',
                              style: button16TextStyle,
                              textScaleFactor: textFactor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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

  void initializedata() {}

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
                  SvgPicture.asset(
                    "assets/images/Product.svg",
                    height: getProportionateScreenHeight(70),
                    width: getProportionateScreenWidth(70),
                  ),
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
                      builder: (context) => const YourCategory()));
            },
            child: Container(
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(10),
                  right: getProportionateScreenWidth(10)),
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/images/Category.svg",
                    height: getProportionateScreenHeight(70),
                    width: getProportionateScreenWidth(70),
                  ),
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
                SvgPicture.asset(
                  "assets/images/Order.svg",
                  height: getProportionateScreenHeight(70),
                  width: getProportionateScreenWidth(70),
                ),
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
                SvgPicture.asset(
                  "assets/images/BestDeal.svg",
                  height: getProportionateScreenHeight(70),
                  width: getProportionateScreenWidth(70),
                ),
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
            /* Container(
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
            )*/
          ],
        ),
      ),
    );
  }
}
