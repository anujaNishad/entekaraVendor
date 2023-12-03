import 'package:cached_network_image/cached_network_image.dart';
import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/add_product/bloc/product_bloc.dart';
import 'package:entekaravendor/pages/advertisement/view/advertisement.dart';
import 'package:entekaravendor/pages/category/view/your_category.dart';
import 'package:entekaravendor/pages/product/view/product_details.dart';
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
      create: (context) => ProductBloc()..add(FetchAdvertisement()),
      child: SafeArea(
        child: BlocListener<ProductBloc, ProductState>(
            listener: (context, state) {},
            child: SingleChildScrollView(
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
                    Padding(
                      padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(15),
                        right: getProportionateScreenWidth(15),
                      ),
                      child: Text(
                        "Advertisement",
                        style: loadingHeadingTextStyle,
                        textScaleFactor: geTextScale(),
                      ),
                    ),
                    heightSpace10,
                    BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                      if (state is ProductVariantLoadingState) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: primaryColor,
                        ));
                      } else if (state is AdvertisementLoadedState) {
                        return state.advertisementData.length > 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.advertisementData.length,
                                itemBuilder: (context, index) {
                                  return state.advertisementData[index]
                                              .status ==
                                          "Active"
                                      ? GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdvertisementDetails(
                                                        advData: state
                                                                .advertisementData[
                                                            index],
                                                      )),
                                            );
                                          },
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                top:
                                                    getProportionateScreenHeight(
                                                        2),
                                                bottom:
                                                    getProportionateScreenHeight(
                                                        2),
                                              ),
                                              padding: EdgeInsets.only(
                                                  right:
                                                      getProportionateScreenWidth(
                                                          10)),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: greyColor),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 2,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  8.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  8.0),
                                                        ),
                                                        child: state
                                                                    .advertisementData[
                                                                        index]
                                                                    .image !=
                                                                null
                                                            ? CachedNetworkImage(
                                                                height:
                                                                    getProportionateScreenHeight(
                                                                        100),
                                                                width:
                                                                    getProportionateScreenWidth(
                                                                        100),
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Image.asset(
                                                                  "assets/images/noimage.jpeg",
                                                                  height:
                                                                      getProportionateScreenHeight(
                                                                          100),
                                                                  width:
                                                                      getProportionateScreenWidth(
                                                                          100),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                                placeholder: (context,
                                                                        url) =>
                                                                    Padding(
                                                                        padding:
                                                                            EdgeInsets.all(getProportionateScreenHeight(
                                                                                40)),
                                                                        child:
                                                                            const CircularProgressIndicator()),
                                                                imageUrl:
                                                                    '${state.advertisementData[index].image}',
                                                              )
                                                            : Image.asset(
                                                                "assets/images/noimage.jpeg",
                                                                height:
                                                                    getProportionateScreenHeight(
                                                                        100),
                                                                width:
                                                                    getProportionateScreenWidth(
                                                                        100),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                      )),
                                                  widthSpace20,
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      "${state.advertisementData[index].title}",
                                                      style: Product16TextStyle,
                                                      textScaleFactor:
                                                          geTextScale(),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        )
                                      : Container();
                                })
                            : Container(
                                child: Center(
                                  child: Text(
                                    'No Data Found',
                                    style: button16BTextStyle,
                                    textScaleFactor: geTextScale(),
                                  ),
                                ),
                              );
                      } else if (state is ErrorState) {
                        return Expanded(
                            flex: 10, child: Center(child: Text(state.error)));
                      } else {
                        return Container();
                      }
                    }),
                  ],
                ),
              ),
            )),
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
}
