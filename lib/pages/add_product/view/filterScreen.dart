import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/Dashboard/bloc/dashboard_bloc.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:entekaravendor/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool isBrand = false;
  bool isCategory = true;
  final storage = GetStorage();
  int vendorId = 0;
  List<dynamic> categoryIds = [];
  List<dynamic> brandIds = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vendorId = int.parse(storage.read("vendorId").toString());
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(getProportionateScreenHeight(50)),
          child: commonAppbar("Filters", context)),
      body: BlocProvider(
        create: (context) => DashboardBloc()..add(FetchYourCategory(vendorId)),
        child: BlocListener<DashboardBloc, DashboardState>(
          listener: (context, state) {},
          child: Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(16)),
            child: BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                if (state is CategoryLoadingState) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: primaryColor,
                  ));
                } else if (state is ErrorState) {
                  return Center(child: Text(state.error));
                } else {
                  return Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isCategory = !isCategory;
                                  isBrand = false;
                                });
                                setState(() {
                                  context
                                      .read<DashboardBloc>()
                                      .add(FetchYourCategory(vendorId));
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(
                                    getProportionateScreenHeight(16)),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: isCategory
                                          ? primaryColor
                                          : greyColor),
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      isCategory ? primaryColor : Colors.white,
                                ),
                                child: Text(
                                  "Category",
                                  style: Product16TextStyle,
                                  textScaleFactor: geTextScale(),
                                ),
                              ),
                            ),
                            widthSpace20,
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isBrand = !isBrand;
                                  isCategory = false;
                                });
                                setState(() {
                                  context
                                      .read<DashboardBloc>()
                                      .add(FetchBrand());
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(
                                    getProportionateScreenHeight(16)),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          isBrand ? primaryColor : greyColor),
                                  borderRadius: BorderRadius.circular(10),
                                  color: isBrand ? primaryColor : Colors.white,
                                ),
                                child: Text(
                                  "Brand",
                                  style: Product16TextStyle,
                                  textScaleFactor: geTextScale(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 4,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (state is YourCategoryLoadedState)
                                  state.categoryDataList!.data!.length > 0
                                      ? Expanded(
                                          flex: 4,
                                          child: GridView.builder(
                                            itemCount: state
                                                .categoryDataList!.data!.length,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount:
                                                        (orientation ==
                                                                Orientation
                                                                    .portrait)
                                                            ? 3
                                                            : 4,
                                                    childAspectRatio: 2.0),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                margin: EdgeInsets.only(
                                                    top:
                                                        getProportionateScreenHeight(
                                                            10),
                                                    bottom:
                                                        getProportionateScreenHeight(
                                                            10)),
                                                padding: EdgeInsets.only(
                                                    left:
                                                        getProportionateScreenWidth(
                                                            10),
                                                    right:
                                                        getProportionateScreenWidth(
                                                            10)),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      state
                                                              .categoryDataList!
                                                              .data![index]
                                                              .isSelect =
                                                          !state
                                                              .categoryDataList!
                                                              .data![index]
                                                              .isSelect;
                                                    });
                                                    if (state
                                                            .categoryDataList!
                                                            .data![index]
                                                            .isSelect ==
                                                        true) {
                                                      addCategory(state
                                                          .categoryDataList!
                                                          .data![index]
                                                          .id);
                                                    } else {
                                                      removeCategory(state
                                                          .categoryDataList!
                                                          .data![index]
                                                          .id);
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left:
                                                            getProportionateScreenWidth(
                                                                10),
                                                        right:
                                                            getProportionateScreenWidth(
                                                                10)),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: state
                                                                      .categoryDataList!
                                                                      .data![
                                                                          index]
                                                                      .isSelect ==
                                                                  true
                                                              ? primaryColor
                                                              : greyColor),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        '${state.categoryDataList!.data![index].name}',
                                                        style: Text10pTextStyle,
                                                        textScaleFactor:
                                                            textFactor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
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
                                        ),
                                if (state is BrandLoadedState)
                                  state.brandData!.data!.length > 0
                                      ? Expanded(
                                          flex: 4,
                                          child: GridView.builder(
                                            itemCount:
                                                state.brandData!.data!.length,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount:
                                                        (orientation ==
                                                                Orientation
                                                                    .portrait)
                                                            ? 3
                                                            : 4,
                                                    childAspectRatio: 2.0),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                margin: EdgeInsets.only(
                                                    top:
                                                        getProportionateScreenHeight(
                                                            10),
                                                    bottom:
                                                        getProportionateScreenHeight(
                                                            10)),
                                                padding: EdgeInsets.only(
                                                    left:
                                                        getProportionateScreenWidth(
                                                            10),
                                                    right:
                                                        getProportionateScreenWidth(
                                                            10)),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      state
                                                              .brandData!
                                                              .data![index]
                                                              .isBrandSelect =
                                                          !state
                                                              .brandData!
                                                              .data![index]
                                                              .isBrandSelect;
                                                    });
                                                    if (state
                                                            .brandData!
                                                            .data![index]
                                                            .isBrandSelect ==
                                                        true) {
                                                      addBrand(state.brandData!
                                                          .data![index].id);
                                                    } else {
                                                      removeBrand(state
                                                          .brandData!
                                                          .data![index]
                                                          .id);
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left:
                                                            getProportionateScreenWidth(
                                                                10),
                                                        right:
                                                            getProportionateScreenWidth(
                                                                10)),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: state
                                                                      .brandData!
                                                                      .data![
                                                                          index]
                                                                      .isBrandSelect ==
                                                                  true
                                                              ? primaryColor
                                                              : greyColor),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        '${state.brandData!.data![index].brandName}',
                                                        style: Text10pTextStyle,
                                                        textScaleFactor:
                                                            textFactor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
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
                                        )
                              ])),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(40),
                                right: getProportionateScreenWidth(40),
                                top: getProportionateScreenHeight(40)),
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(
                                      context, [categoryIds, brandIds]);
                                },
                                child: Text(
                                  'Add Filter',
                                  style: button16TextStyle,
                                  textScaleFactor: textFactor,
                                ),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  )),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          primaryColor),
                                  padding: MaterialStateProperty
                                      .all<EdgeInsets>(EdgeInsets.symmetric(
                                          horizontal:
                                              getProportionateScreenWidth(60),
                                          vertical:
                                              getProportionateScreenHeight(
                                                  15))),
                                )),
                          ))
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void addCategory(int? id) {
    print("cat ids=$id");
    categoryIds.add(id);
    print("cat list=${categoryIds}");
  }

  void removeCategory(int? id) {
    categoryIds.remove(id);
    print("cat list2=${categoryIds}");
  }

  void addBrand(int? id) {
    print("cat ids=$id");
    brandIds.add(id);
    print("brands list=${brandIds}");
  }

  void removeBrand(int? id) {
    brandIds.remove(id);
    print("brand list2 = ${categoryIds}");
  }
}
