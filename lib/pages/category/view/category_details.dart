import 'package:cached_network_image/cached_network_image.dart';
import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/Dashboard/bloc/dashboard_bloc.dart';
import 'package:entekaravendor/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({Key? key}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  final storage = GetStorage();
  int vendorId = 0;
  List<dynamic> categoryIds = [];

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
          preferredSize: Size.fromHeight(50.0.sp),
          child: commonAppbar("Category", context)),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => DashboardBloc()..add(FetchCategory(vendorId)),
          child: BlocListener<DashboardBloc, DashboardState>(
              listener: (context, state) {
                if (state is UpdateCategoryLoadedState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text("Category updated successfully !!"),
                    duration: const Duration(seconds: 4),
                    action: SnackBarAction(
                      label: '',
                      onPressed: () {},
                    ),
                  ));
                  context.read<DashboardBloc>().add(FetchCategory(vendorId));
                } else if (state is ErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.error),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {},
                    ),
                  ));
                  context.read<DashboardBloc>().add(FetchCategory(vendorId));
                }
              },
              child: Padding(
                  padding: EdgeInsets.only(top: 20.sp, bottom: 20.sp),
                  child: BlocBuilder<DashboardBloc, DashboardState>(
                      builder: (context, state) {
                    if (state is CategoryLoadingState) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: primaryColor,
                      ));
                    } else if (state is CategoryLoadedState) {
                      return state.categoryList!.category!.length > 0
                          ? Column(
                              children: [
                                Expanded(
                                    flex: 10,
                                    child: GridView.builder(
                                      itemCount:
                                          state.categoryList!.category!.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: (orientation ==
                                                      Orientation.portrait)
                                                  ? 3
                                                  : 4,
                                              childAspectRatio: 0.94),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10.sp, right: 10.sp),
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      state
                                                              .categoryList!
                                                              .category![index]
                                                              .isSelect =
                                                          !state
                                                              .categoryList!
                                                              .category![index]
                                                              .isSelect;
                                                    });
                                                    if (state
                                                            .categoryList!
                                                            .category![index]
                                                            .isSelect ==
                                                        true) {
                                                      addCategory(state
                                                          .categoryList!
                                                          .category![index]
                                                          .id);
                                                    } else {
                                                      removeCategory(state
                                                          .categoryList!
                                                          .category![index]
                                                          .id);
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(16.sp),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.sp),
                                                      border: Border.all(
                                                          color: state
                                                                      .categoryList!
                                                                      .category![
                                                                          index]
                                                                      .isSelect ==
                                                                  true
                                                              ? primaryColor
                                                              : greyColor),
                                                    ),
                                                    child: state
                                                                .categoryList!
                                                                .category![
                                                                    index]
                                                                .image !=
                                                            null
                                                        ? CachedNetworkImage(
                                                            height: 45.sp,
                                                            width: 70.sp,
                                                            fit: BoxFit.cover,
                                                            placeholder: (context,
                                                                    url) =>
                                                                const CircularProgressIndicator(),
                                                            imageUrl:
                                                                '${state.categoryList!.category![index].image}',
                                                          )
                                                        : Image.asset(
                                                            "assets/images/noimage.jpeg",
                                                            height: 45.sp,
                                                            width: 70.sp,
                                                            fit: BoxFit.cover,
                                                          ),
                                                  ),
                                                ),
                                                heightSpace,
                                                Text(
                                                  '${state.categoryList!.category![index].name}',
                                                  style: Text10pTextStyle,
                                                  textScaleFactor: textFactor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )),
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 40.sp, right: 40.sp),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        context.read<DashboardBloc>().add(
                                            UpdateCategory(
                                                vendorId, categoryIds));
                                      },
                                      child: Text(
                                        'Add Category',
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
                                        padding: MaterialStateProperty.all<
                                                EdgeInsets>(
                                            EdgeInsets.symmetric(
                                                horizontal: 60.sp,
                                                vertical: 15.sp)),
                                      )),
                                ))
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
                  }))),
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
}
