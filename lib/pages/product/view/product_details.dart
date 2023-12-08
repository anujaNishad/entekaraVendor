import 'package:cached_network_image/cached_network_image.dart';
import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/add_product/bloc/product_bloc.dart';
import 'package:entekaravendor/pages/add_product/view/add_product.dart';
import 'package:entekaravendor/pages/add_product/view/filterScreen.dart';
import 'package:entekaravendor/pages/product/view/product_edit_details.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_storage/get_storage.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key, required this.isBack}) : super(key: key);
  final bool isBack;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final TextEditingController searchController = new TextEditingController();
  final storage = GetStorage();
  int vendorId = 0;
  List<dynamic> catIds = [];
  List<dynamic> brandIds = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vendorId = int.parse(storage.read("vendorId").toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(getProportionateScreenHeight(50)),
            child: AppBar(
              elevation: 0,
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              automaticallyImplyLeading: false,
              leading: widget.isBack == true
                  ? InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios_new_outlined),
                    )
                  : Container(),
              centerTitle: true,
              title: Text(
                "Your Products",
                style: appbarTextStyle,
                textScaleFactor: geTextScale(),
              ),
            )),
        body: BlocProvider(
            create: (context) =>
                ProductBloc()..add(FetchProductItem(vendorId, "")),
            child: SafeArea(
              child: Stack(
                children: [
                  BlocListener<ProductBloc, ProductState>(
                    listener: (context, state) {
                      if (state is DeleteProductVariantLoadedState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Product deleted successfully !!"),
                          duration: const Duration(seconds: 4),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        ));
                        context
                            .read<ProductBloc>()
                            .add(FetchProductItem(vendorId, ""));
                      } else if (state is ErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("${state.error}"),
                          duration: const Duration(seconds: 4),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        ));
                      }
                    },
                    child: BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                      if (state is ProductVariantLoadingState) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: primaryColor,
                        ));
                      } else if (state is ProductVariantItemLoadedState) {
                        return state.productItemList!.data!.length > 0
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: getProportionateScreenWidth(16),
                                    right: getProportionateScreenWidth(16),
                                    bottom: getProportionateScreenHeight(60)),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        context.read<ProductBloc>().add(
                                            FetchProductItem(vendorId, ""));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: getProportionateScreenHeight(10),
                                        bottom:
                                            getProportionateScreenHeight(10),
                                      ),
                                      child: TextFormField(
                                        cursorColor: primaryColor,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    12)),
                                        decoration: new InputDecoration(
                                          prefixIcon: Icon(Icons.search),
                                          suffixIcon: GestureDetector(
                                              onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            FilterScreen()),
                                                  ).then((value) {
                                                    print("value=$value");
                                                    print("value=${value[0]}");
                                                    print("value=${value[1]}");
                                                    catIds = value[0];
                                                    brandIds = value[1];
                                                    setState(() {
                                                      context
                                                          .read<ProductBloc>()
                                                          .add(FetchFilterProductVariant(
                                                              vendorId,
                                                              searchController
                                                                  .text,
                                                              catIds,
                                                              brandIds));
                                                    });
                                                  }),
                                              child: Image.asset(
                                                  "assets/images/filter.png")),
                                          labelText: "Search in your Stock",
                                          labelStyle: TextStyle(
                                              fontSize:
                                                  getProportionateScreenHeight(
                                                      14)),
                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                  color: Colors.blue)),
                                          contentPadding: EdgeInsets.only(
                                              bottom: 10.0,
                                              left: 10.0,
                                              right: 10.0),
                                        ),
                                        controller: searchController,
                                        onFieldSubmitted: (val) {
                                          setState(() {
                                            context.read<ProductBloc>().add(
                                                FetchProductItem(vendorId,
                                                    searchController.text));
                                          });
                                        },
                                        validator: (name) {},
                                      ),
                                    ),
                                    /*   Row(
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
                                            itemCount: state
                                                .productItemList!.data!.length,
                                            itemBuilder: (context, index) {
                                              String sPrice = state
                                                  .productItemList!
                                                  .data![index]
                                                  .price!
                                                  .toString()
                                                  .replaceAll(",", "");
                                              double op = double.parse(sPrice) /
                                                  (1 -
                                                      (double.parse(state
                                                              .productItemList!
                                                              .data![index]
                                                              .discount
                                                              .toString()) /
                                                          100));
                                              String oPrice =
                                                  op.toStringAsFixed(2);
                                              return Slidable(
                                                // Specify a key if the Slidable is dismissible.
                                                key: const ValueKey(1),
                                                // The end action pane is the one at the right or the bottom side.
                                                endActionPane: ActionPane(
                                                  motion: const ScrollMotion(),
                                                  dismissible: DismissiblePane(
                                                      onDismissed: () {
                                                    context
                                                        .read<ProductBloc>()
                                                        .add(DeleteProductVariant(
                                                            state
                                                                .productItemList!
                                                                .data![index]
                                                                .id!,
                                                            vendorId));
                                                  }),
                                                  children: [
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ProductEditItemDetails(
                                                                          variantData: state
                                                                              .productItemList!
                                                                              .data![index],
                                                                        )),
                                                          );
                                                        },
                                                        child: Container(
                                                          width:
                                                              getProportionateScreenWidth(
                                                                  100),
                                                          height:
                                                              getProportionateScreenHeight(
                                                                  100),
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  primaryColor),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .edit_outlined,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              Text(
                                                                "Edit",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                textScaleFactor:
                                                                    geTextScale(),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          context
                                                              .read<
                                                                  ProductBloc>()
                                                              .add(DeleteProductVariant(
                                                                  state
                                                                      .productItemList!
                                                                      .data![
                                                                          index]
                                                                      .id!,
                                                                  vendorId));
                                                        },
                                                        child: Container(
                                                          width:
                                                              getProportionateScreenWidth(
                                                                  100),
                                                          height:
                                                              getProportionateScreenHeight(
                                                                  100),
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: redColor),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .delete_rounded,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              Text("Delete",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                  textScaleFactor:
                                                                      geTextScale())
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),

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
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.white),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      8.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      8.0),
                                                            ),
                                                            child: state
                                                                        .productItemList!
                                                                        .data![
                                                                            index]
                                                                        .productImage !=
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
                                                                    placeholder: (context, url) => Padding(
                                                                        padding:
                                                                            EdgeInsets.all(getProportionateScreenHeight(
                                                                                40)),
                                                                        child:
                                                                            const CircularProgressIndicator()),
                                                                    imageUrl:
                                                                        '${state.productItemList!.data![index].productImage}',
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
                                                          ),
                                                        ),
                                                        widthSpace10,
                                                        Expanded(
                                                            flex: 4,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 4,
                                                                      child:
                                                                          Text(
                                                                        "${state.productItemList!.data![index].productTitle}",
                                                                        style:
                                                                            Product16TextStyle,
                                                                        textScaleFactor:
                                                                            geTextScale(),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                          Text(
                                                                        "${state.productItemList!.data![index].productUnit}",
                                                                        style:
                                                                            Text10STextStyle,
                                                                        textScaleFactor:
                                                                            geTextScale(),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                heightSpace10,
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      '\u{20B9} ${oPrice}',
                                                                      style:
                                                                          Text12bLTextStyle,
                                                                      textScaleFactor:
                                                                          geTextScale(),
                                                                    ),
                                                                    Text(
                                                                      '${state.productItemList!.data![index].price}',
                                                                      style:
                                                                          Text12boldTextStyle,
                                                                      textScaleFactor:
                                                                          geTextScale(),
                                                                    ),
                                                                    Text(
                                                                      "Discount: ${state.productItemList!.data![index].discount} %",
                                                                      style:
                                                                          Text10STextStyle,
                                                                      textScaleFactor:
                                                                          geTextScale(),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ))
                                                      ],
                                                    )),
                                              );
                                            }))
                                  ],
                                ),
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
                                      .add(FetchProductItem(vendorId, ""));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.refresh_outlined),
                                    Text(
                                      "Refresh",
                                      style: OTPHeading14TextStyle,
                                      textScaleFactor: textFactor,
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
                  ),
                  Positioned(
                    bottom: getProportionateScreenHeight(10),
                    left: getProportionateScreenWidth(80),
                    right: getProportionateScreenWidth(80),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddProduct()),
                        );
                      },
                      child: Container(
                        height: getProportionateScreenHeight(30),
                        width: getProportionateScreenWidth(182),
                        padding: EdgeInsets.only(
                          //  left: getProportionateScreenWidth(10),
                          top: getProportionateScreenHeight(5),
                          // right: getProportionateScreenWidth(10),
                          bottom: getProportionateScreenHeight(5),
                        ),
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(
                          child: Text(
                            'Add Product',
                            style: Text12TextTextStyle,
                            textScaleFactor: textFactor,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
