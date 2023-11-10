import 'package:cached_network_image/cached_network_image.dart';
import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/model/productdetails_model.dart';
import 'package:entekaravendor/pages/add_product/bloc/product_bloc.dart';
import 'package:entekaravendor/pages/add_product/view/add_product.dart';
import 'package:entekaravendor/pages/product/view/product_edit_details.dart';
import 'package:entekaravendor/widgets/product_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_storage/get_storage.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final TextEditingController searchController = new TextEditingController();
  final storage = GetStorage();
  int vendorId = 0;

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
            preferredSize: Size.fromHeight(50.0.sp),
            child: productAppbar("Product", context)),
        body: BlocProvider(
            create: (context) =>
                ProductBloc()..add(FetchProductItem(vendorId, "")),
            child: SafeArea(
              child: BlocListener<ProductBloc, ProductState>(
                listener: (context, state) {},
                child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                  if (state is ProductVariantLoadingState) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: primaryColor,
                    ));
                  } else if (state is ProductVariantItemLoadedState) {
                    return state.productItemList!.data!.length > 0
                        ? Stack(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 16.sp, right: 16.sp),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 10.sp,
                                        bottom: 10.sp,
                                      ),
                                      child: TextFormField(
                                        cursorColor: primaryColor,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp),
                                        decoration: new InputDecoration(
                                          prefixIcon: Icon(Icons.search),
                                          labelText: "Search in your Stock",
                                          labelStyle:
                                              TextStyle(fontSize: 14.sp),
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
                                    heightSpace20,
                                    Expanded(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: state
                                                .productItemList!.data!.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                  bottom: 10.sp,
                                                  top: 10.sp,
                                                ),
                                                child: Slidable(
                                                  // Specify a key if the Slidable is dismissible.
                                                  key: const ValueKey(1),
                                                  // The end action pane is the one at the right or the bottom side.
                                                  endActionPane: ActionPane(
                                                    motion:
                                                        const ScrollMotion(),
                                                    dismissible:
                                                        DismissiblePane(
                                                            onDismissed: () {}),
                                                    children: [
                                                      SlidableAction(
                                                        // An action can be bigger than the others.
                                                        flex: 2,
                                                        onPressed: (val) {
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
                                                        backgroundColor:
                                                            primaryColor,
                                                        foregroundColor:
                                                            textColor,
                                                        icon: Icons.edit,
                                                        label: 'Edit',
                                                      ),
                                                      SlidableAction(
                                                        onPressed: doNothing1,
                                                        backgroundColor:
                                                            redColor,
                                                        foregroundColor:
                                                            textColor,
                                                        icon: Icons.delete,
                                                        label: 'Delete',
                                                      ),
                                                    ],
                                                  ),

                                                  child: Container(
                                                      padding: EdgeInsets.only(
                                                          top: 10.sp,
                                                          bottom: 10.sp,
                                                          left: 10.sp,
                                                          right: 10.sp),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: greyColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.white),
                                                      child: Row(
                                                        children: [
                                                          state
                                                                      .productItemList!
                                                                      .data![
                                                                          index]
                                                                      .productImage !=
                                                                  null
                                                              ? CachedNetworkImage(
                                                                  height:
                                                                      100.sp,
                                                                  width: 100.sp,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      const CircularProgressIndicator(),
                                                                  imageUrl:
                                                                      '${state.productItemList!.data![index].productImage}',
                                                                )
                                                              : Image.asset(
                                                                  "assets/images/noimage.jpeg",
                                                                  height: 45.sp,
                                                                  width: 70.sp,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "${state.productItemList!.data![index].productTitle}",
                                                                style:
                                                                    Product16TextStyle,
                                                                textScaleFactor:
                                                                    textFactor,
                                                              ),
                                                              Text(
                                                                "${state.productItemList!.data![index].productUnit}",
                                                                style:
                                                                    Text8NTextStyle,
                                                                textScaleFactor:
                                                                    textFactor,
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      )),
                                                ),
                                              );
                                            }))
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 10.sp,
                                left: 40.sp,
                                right: 40.sp,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddProduct()),
                                      );
                                    },
                                    child: Text(
                                      'Add Product',
                                      style: button16TextStyle,
                                      textScaleFactor: textFactor,
                                    ),
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0.sp),
                                      )),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              primaryColor),
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              EdgeInsets.symmetric(
                                                  horizontal: 60.sp,
                                                  vertical: 15.sp)),
                                    )),
                              )
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
                  } else if (state is ErrorState) {
                    return Text(state.error);
                  } else {
                    return Container();
                  }
                }),
              ),
            )));
  }
}

void doNothing(BuildContext context, Datum datum) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ProductEditItemDetails()),
  );
}

void doNothing1(BuildContext context) {}
