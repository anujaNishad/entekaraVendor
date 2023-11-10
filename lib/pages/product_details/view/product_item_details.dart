import 'package:cached_network_image/cached_network_image.dart';
import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/model/productVarientModel.dart' as variant;
import 'package:entekaravendor/pages/add_product/bloc/product_bloc.dart';
import 'package:entekaravendor/pages/product/view/product_details.dart';
import 'package:entekaravendor/widgets/backbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class ProductItemDetails extends StatefulWidget {
  const ProductItemDetails({Key? key, this.variantData}) : super(key: key);
  final variant.Datum? variantData;

  @override
  State<ProductItemDetails> createState() => _ProductItemDetailsState();
}

class _ProductItemDetailsState extends State<ProductItemDetails> {
  final TextEditingController sellingController = new TextEditingController();
  final TextEditingController discountController = new TextEditingController();
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
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0.sp), child: backAppbar(context)),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ProductBloc(),
          child: SingleChildScrollView(
              child: BlocListener<ProductBloc, ProductState>(
                  listener: (context, state) {
            if (state is AddProductVariantLoadedState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text("Data  added successfully !!"),
                duration: const Duration(seconds: 4),
                action: SnackBarAction(
                  label: '',
                  onPressed: () {},
                ),
              ));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProductDetails()),
              );
            } else if (state is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error),
                duration: const Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'OK',
                  onPressed: () {},
                ),
              ));
            }
          }, child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: widget.variantData!.thumbnailImage != null
                          ? CachedNetworkImage(
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              imageUrl: '${widget.variantData!.thumbnailImage}',
                            )
                          : Image.asset(
                              "assets/images/noimage.jpeg",
                              height: 45.sp,
                              width: 70.sp,
                              fit: BoxFit.cover,
                            ),
                    ),
                    heightSpace40,
                    Text(
                      '${widget.variantData!.variantTitle}',
                      style: Text24STextStyle,
                      textScaleFactor: textFactor,
                    ),
                    /*Text(
                      'MRP ₹27',
                      style: Text12bTextStyle,
                      textScaleFactor: textFactor,
                    ),*/
                    heightSpace20,
                    Text(
                      convertHtmlToString(
                          widget.variantData!.variantDescription),
                      style: Text12bTextStyle,
                      textScaleFactor: textFactor,
                      textAlign: TextAlign.justify,
                    ),
                    heightSpace40,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Set Selling Price',
                          style: button16BTextStyle,
                          textScaleFactor: textFactor,
                        ),
                        Text(
                          'Set Discount',
                          style: button16BTextStyle,
                          textScaleFactor: textFactor,
                        ),
                      ],
                    ),
                    heightSpace10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              '\u{20B9}',
                              style: button16BTextStyle,
                              textScaleFactor: textFactor,
                            )),
                        Expanded(
                            flex: 5,
                            child: TextFormField(
                              cursorColor: primaryColor,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 12.sp),
                              decoration: new InputDecoration(
                                labelText: "",
                                labelStyle: TextStyle(fontSize: 14.sp),
                                //floatingLabelBehavior: FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                      color: Color(0xFFE1DFDD), width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                      color: Color(0xFFE1DFDD), width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(color: Colors.blue)),
                                contentPadding: EdgeInsets.only(
                                    bottom: 10.0, left: 10.0, right: 10.0),
                              ),
                              controller: sellingController,
                              validator: (name) {},
                            )),
                        SizedBox(
                          width: 140.sp,
                        ),
                        Expanded(
                            flex: 5,
                            child: TextFormField(
                              cursorColor: primaryColor,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 12.sp),
                              decoration: new InputDecoration(
                                labelText: "",
                                labelStyle: TextStyle(fontSize: 14.sp),
                                //floatingLabelBehavior: FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                      color: Color(0xFFE1DFDD), width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                      color: Color(0xFFE1DFDD), width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(color: Colors.blue)),
                                contentPadding: EdgeInsets.only(
                                    bottom: 10.0, left: 10.0, right: 10.0),
                              ),
                              controller: discountController,
                              validator: (name) {},
                            )),
                        widthSpace,
                        Expanded(
                            flex: 1,
                            child: Text(
                              '%',
                              style: button16BTextStyle,
                              textScaleFactor: textFactor,
                            )),
                      ],
                    ),
                    heightSpace40,
                    Padding(
                      padding: EdgeInsets.only(left: 70.sp, right: 70.sp),
                      child: ElevatedButton(
                          onPressed: () {
                            if (sellingController.text != "" &&
                                discountController.text != "") {
                              context.read<ProductBloc>().add(AddProductVariant(
                                  vendorId,
                                  widget.variantData!.productId!,
                                  widget.variantData!.id!,
                                  sellingController.text,
                                  discountController.text));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text(
                                    "Selling Price and Discount Required"),
                                duration: const Duration(seconds: 4),
                                action: SnackBarAction(
                                  label: '',
                                  onPressed: () {},
                                ),
                              ));
                            }
                          },
                          child: Text(
                            'Add Item',
                            style: button16TextStyle,
                            textScaleFactor: textFactor,
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0.sp),
                            )),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(primaryColor),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.symmetric(
                                    horizontal: 60.sp, vertical: 15.sp)),
                          )),
                    )
                  ],
                ),
              );
            },
          ))),
        ),
      ),
    );
  }

  String convertHtmlToString(String? variantDescription) {
    String convertValue = "";
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return variantDescription!.replaceAll(exp, "").trim();
  }
}
