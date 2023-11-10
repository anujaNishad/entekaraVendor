import 'package:cached_network_image/cached_network_image.dart';
import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/add_product/bloc/product_bloc.dart';
import 'package:entekaravendor/pages/add_product/view/product_varient.dart';
import 'package:entekaravendor/widgets/product_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            child: productAppbar("Add Product", context)),
        body: SafeArea(
          child: BlocProvider(
            create: (context) => ProductBloc()..add(FetchProduct(vendorId, "")),
            child: Padding(
                padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
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
                      return state.productList!.data!.length > 0
                          ? Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 10.sp,
                                    bottom: 10.sp,
                                  ),
                                  child: TextFormField(
                                    cursorColor: primaryColor,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.sp),
                                    decoration: new InputDecoration(
                                      prefixIcon: Icon(Icons.search),
                                      labelText: "Search anything",
                                      labelStyle: TextStyle(fontSize: 14.sp),
                                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFFE1DFDD), width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFFE1DFDD), width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          borderSide:
                                              BorderSide(color: Colors.blue)),
                                      contentPadding: EdgeInsets.only(
                                          bottom: 10.0,
                                          left: 10.0,
                                          right: 10.0),
                                    ),
                                    controller: searchController,
                                    onFieldSubmitted: (val) {
                                      setState(() {
                                        context.read<ProductBloc>().add(
                                            FetchProduct(vendorId,
                                                searchController.text));
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
                                heightSpace20,
                                Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            state.productList!.data!.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 10.sp,
                                              top: 10.sp,
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
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: state
                                                                  .productList!
                                                                  .data![index]
                                                                  .image !=
                                                              null
                                                          ? CachedNetworkImage(
                                                              placeholder: (context,
                                                                      url) =>
                                                                  const CircularProgressIndicator(),
                                                              imageUrl:
                                                                  '${state.productList!.data![index].image}',
                                                            )
                                                          : Image.asset(
                                                              "assets/images/noimage.jpeg",
                                                              height: 45.sp,
                                                              width: 70.sp,
                                                              fit: BoxFit.cover,
                                                            ),
                                                    ),
                                                    widthSpace10,
                                                    Expanded(
                                                        flex: 3,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "${state.productList!.data![index].title}",
                                                              style:
                                                                  Product16TextStyle,
                                                              textScaleFactor:
                                                                  textFactor,
                                                            ),
                                                            Text(
                                                              "${state.productList!.data![index].unitId}",
                                                              style:
                                                                  Text8NTextStyle,
                                                              textScaleFactor:
                                                                  textFactor,
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
                                                                    builder:
                                                                        (context) =>
                                                                            ProductVariants(
                                                                              productId: state.productList!.data![index].id,
                                                                            )),
                                                              );
                                                            },
                                                            child: Icon(
                                                                Icons.add)))
                                                  ],
                                                )),
                                          );
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
                    } else if (state is ErrorState) {
                      return Text(state.error);
                    } else {
                      return Container();
                    }
                  }),
                )),
          ),
        ));
  }
}
