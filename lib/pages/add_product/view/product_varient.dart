import 'package:cached_network_image/cached_network_image.dart';
import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/add_product/bloc/product_bloc.dart';
import 'package:entekaravendor/pages/product_details/view/product_item_details.dart';
import 'package:entekaravendor/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class ProductVariants extends StatefulWidget {
  const ProductVariants({Key? key, this.productId}) : super(key: key);
  final int? productId;

  @override
  State<ProductVariants> createState() => _ProductVariantsState();
}

class _ProductVariantsState extends State<ProductVariants> {
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
            child: commonAppbar("Product Variants", context)),
        body: SafeArea(
          child: BlocProvider(
            create: (context) =>
                ProductBloc()..add(FetchProductVariant(widget.productId!)),
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
                    } else if (state is ProductVariantLoadedState) {
                      return state.productVariantList!.data!.length > 0
                          ? Column(
                              children: [
                                Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: state
                                            .productVariantList!.data!.length,
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
                                                                  .productVariantList!
                                                                  .data![index]
                                                                  .thumbnailImage !=
                                                              null
                                                          ? CachedNetworkImage(
                                                              placeholder: (context,
                                                                      url) =>
                                                                  const CircularProgressIndicator(),
                                                              imageUrl:
                                                                  '${state.productVariantList!.data![index].thumbnailImage}',
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
                                                              "${state.productVariantList!.data![index].variantTitle}",
                                                              style:
                                                                  Product16TextStyle,
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
                                                                            ProductItemDetails(
                                                                              variantData: state.productVariantList!.data![index],
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
