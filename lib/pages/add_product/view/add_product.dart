import 'package:cached_network_image/cached_network_image.dart';
import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/add_product/bloc/product_bloc.dart';
import 'package:entekaravendor/pages/add_product/view/filterScreen.dart';
import 'package:entekaravendor/pages/add_product/view/product_varient.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController searchController = new TextEditingController();
  final storage = GetStorage();
  int vendorId = 0;
  List<dynamic> catIds = [];
  List<dynamic> brandIds = [];
  final bloc = ProductBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vendorId = int.parse(storage.read("vendorId").toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(FetchProduct(vendorId, "")),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(getProportionateScreenHeight(50)),
              child: AppBar(
                elevation: 0,
                shadowColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                automaticallyImplyLeading: false,
                leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios_new_outlined),
                ),
                centerTitle: true,
                title: Text(
                  "Add Product",
                  style: appbarTextStyle,
                  textScaleFactor: textFactor,
                ),
              )),
          body: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(16),
                    right: getProportionateScreenWidth(16)),
                child: BlocListener<ProductBloc, ProductState>(
                  listener: (context, state) {},
                  child: BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                    if (state is ProductVariantLoadingState) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: primaryColor,
                      ));
                    } else if (state is ProductLoadedState) {
                      return addProductItemDetails(state, context);
                    } else if (state is ErrorState) {
                      return Padding(
                        padding:
                            EdgeInsets.all(getProportionateScreenHeight(16)),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                context
                                    .read<ProductBloc>()
                                    .add(FetchProduct(vendorId, ""));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.refresh_outlined),
                                  Text(
                                    "Refresh",
                                    style: OTPHeading14TextStyle,
                                    textScaleFactor: geTextScale(),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(260),
                            ),
                            Center(child: Text(state.error))
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
                )),
          )),
    );
  }

  Widget addProductItemDetails(ProductLoadedState state, BuildContext context) {
    return state.productList!.data!.length > 0
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  context.read<ProductBloc>().add(FetchProduct(vendorId, ""));
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.refresh_outlined),
                      Text(
                        "Refresh",
                        style: OTPHeading14TextStyle,
                        textScaleFactor: geTextScale(),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(10),
                  bottom: getProportionateScreenHeight(10),
                ),
                child: TextFormField(
                  cursorColor: primaryColor,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenHeight(12)),
                  decoration: new InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: GestureDetector(
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FilterScreen()),
                            ).then((value) {
                              print("value=$value");
                              print("value=${value[0]}");
                              print("value=${value[1]}");
                              catIds = value[0];
                              brandIds = value[1];
                              setState(() {
                                context.read<ProductBloc>().add(
                                    FetchFilterProduct(
                                        vendorId,
                                        searchController.text,
                                        catIds,
                                        brandIds));
                              });
                            }),
                        child: Image.asset("assets/images/filter.png")),
                    labelText: "Search anything",
                    labelStyle:
                        TextStyle(fontSize: getProportionateScreenHeight(14)),
                    //floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide:
                          BorderSide(color: Color(0xFFE1DFDD), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide:
                          BorderSide(color: Color(0xFFE1DFDD), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.blue)),
                    contentPadding:
                        EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                  ),
                  controller: searchController,
                  onFieldSubmitted: (val) {
                    setState(() {
                      context
                          .read<ProductBloc>()
                          .add(FetchProduct(vendorId, searchController.text));
                    });
                  },
                  validator: (name) {},
                ),
              ),
              /*Row(
            children: [
            Expanded(
              flex: 1,
              child: Divider(
                color: Colors.black,
                thickness: 1,
              ),
            ),
            widthSpace,
             Expanded(
              flex: 1,
              child: Text(
                "Dairy",
                style: Text12bTextStyle,
                textScaleFactor: textFactor,
              ),
            ),
               Expanded(
              flex: 8,
              child: Divider(
                color: Colors.black,
                thickness: 1,
              ),
            ),
            ],
          ),*/

              Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.productList!.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.only(
                              top: getProportionateScreenHeight(2),
                              bottom: getProportionateScreenHeight(2),
                            ),
                            padding: EdgeInsets.only(
                                right: getProportionateScreenWidth(10)),
                            decoration: BoxDecoration(
                              border: Border.all(color: greyColor),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        bottomLeft: Radius.circular(8.0),
                                      ),
                                      child: state.productList!.data![index]
                                                  .image !=
                                              null
                                          ? CachedNetworkImage(
                                              height:
                                                  getProportionateScreenHeight(
                                                      100),
                                              width:
                                                  getProportionateScreenWidth(
                                                      100),
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              imageUrl:
                                                  '${state.productList!.data![index].image}',
                                            )
                                          : Image.asset(
                                              "assets/images/noimage.jpeg",
                                              height:
                                                  getProportionateScreenHeight(
                                                      100),
                                              width:
                                                  getProportionateScreenWidth(
                                                      100),
                                              fit: BoxFit.cover,
                                            ),
                                    )),
                                widthSpace20,
                                Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${state.productList!.data![index].title}",
                                          style: Product16TextStyle,
                                          textScaleFactor: geTextScale(),
                                        ),
                                        Text(
                                          "${state.productList!.data![index].unit}",
                                          style: Text8NTextStyle,
                                          textScaleFactor: geTextScale(),
                                        ),
                                      ],
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductVariants(
                                                      productId: state
                                                          .productList!
                                                          .data![index]
                                                          .id,
                                                    )),
                                          );
                                        },
                                        child: Icon(
                                          Icons.add,
                                          size:
                                              getProportionateScreenHeight(30),
                                        )))
                              ],
                            ));
                      }))
            ],
          )
        : Container(
            child: Center(
              child: Text(
                'No Data Found',
                style: button16BTextStyle,
                textScaleFactor: textFactor,
              ),
            ),
          );
  }
}
