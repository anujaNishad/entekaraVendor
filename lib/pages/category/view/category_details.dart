import 'package:cached_network_image/cached_network_image.dart';
import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/Dashboard/bloc/dashboard_bloc.dart';
import 'package:entekaravendor/pages/category/view/your_category.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:entekaravendor/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({Key? key}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  final storage = GetStorage();
  int vendorId = 0;
  List<dynamic> categoryIds = [];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    vendorId = int.parse(storage.read("vendorId").toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(getProportionateScreenHeight(50)),
          child: commonAppbar("All Category", context)),
      body: BlocProvider(
        create: (context) => DashboardBloc()..add(FetchCategory(vendorId)),
        child: BlocListener<DashboardBloc, DashboardState>(
          listener: (context, state) {
            if (state is UpdateCategoryLoadedState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Container(
                    height: getProportionateScreenHeight(40),
                    child: Text("Category updated successfully !!")),
                duration: const Duration(seconds: 4),
                action: SnackBarAction(
                  label: '',
                  onPressed: () {},
                ),
              ));
              //context.read<DashboardBloc>().add(FetchCategory(vendorId));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const YourCategory()));
            } else if (state is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Container(
                  height: getProportionateScreenHeight(40),
                  child: Text("${state.error}"),
                ),
                duration: const Duration(seconds: 4),
                action: SnackBarAction(
                  label: '',
                  onPressed: () {},
                ),
              ));
            }
          },
          child: Padding(
            padding: EdgeInsets.only(
                left: getProportionateScreenWidth(16),
                right: getProportionateScreenWidth(16)),
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
                          heightSpace,
                          Expanded(
                              flex: 8,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      state.categoryList!.category!.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        margin: EdgeInsets.only(
                                          top: getProportionateScreenHeight(2),
                                          bottom:
                                              getProportionateScreenHeight(2),
                                        ),
                                        padding: EdgeInsets.only(
                                            right: getProportionateScreenWidth(
                                                10)),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: state
                                                          .categoryList!
                                                          .category![index]
                                                          .isSelect ==
                                                      true
                                                  ? primaryColor
                                                  : greyColor),
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
                                                        Radius.circular(8.0),
                                                    bottomLeft:
                                                        Radius.circular(8.0),
                                                  ),
                                                  child: state
                                                              .categoryList!
                                                              .category![index]
                                                              .image !=
                                                          null
                                                      ? CachedNetworkImage(
                                                          height:
                                                              getProportionateScreenHeight(
                                                                  100),
                                                          width:
                                                              getProportionateScreenWidth(
                                                                  100),
                                                          fit: BoxFit.contain,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Image.asset(
                                                            "assets/images/noimage.jpeg",
                                                            height:
                                                                getProportionateScreenHeight(
                                                                    100),
                                                            width:
                                                                getProportionateScreenWidth(
                                                                    100),
                                                            fit: BoxFit.cover,
                                                          ),
                                                          placeholder: (context,
                                                                  url) =>
                                                              Padding(
                                                                  padding: EdgeInsets.all(
                                                                      getProportionateScreenHeight(
                                                                          40)),
                                                                  child:
                                                                      const CircularProgressIndicator()),
                                                          imageUrl:
                                                              '${state.categoryList!.category![index].image}',
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
                                              child: Text(
                                                "${state.categoryList!.category![index].name}",
                                                style: Product16TextStyle,
                                                textScaleFactor: geTextScale(),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        state
                                                                .categoryList!
                                                                .category![index]
                                                                .isSelect =
                                                            !state
                                                                .categoryList!
                                                                .category![
                                                                    index]
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
                                                      height:
                                                          getProportionateScreenHeight(
                                                              30),
                                                      width:
                                                          getProportionateScreenWidth(
                                                              30),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: state
                                                                    .categoryList!
                                                                    .category![
                                                                        index]
                                                                    .isSelect ==
                                                                false
                                                            ? primaryColor
                                                            : Colors.red,
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                          state
                                                                      .categoryList!
                                                                      .category![
                                                                          index]
                                                                      .isSelect ==
                                                                  false
                                                              ? Icons.add
                                                              : Icons.remove,
                                                          color: Colors.white,
                                                          size:
                                                              getProportionateScreenHeight(
                                                                  20),
                                                        ),
                                                      ),
                                                    )))
                                          ],
                                        ));
                                  })),
                          categoryIds.length > 0
                              ? Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: getProportionateScreenWidth(40),
                                        right: getProportionateScreenWidth(40),
                                        top: getProportionateScreenHeight(10),
                                        bottom:
                                            getProportionateScreenHeight(10)),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          context.read<DashboardBloc>().add(
                                              UpdateCategory(
                                                  vendorId, categoryIds));
                                        },
                                        child: Text(
                                          'Add Category',
                                          style: Text12TextTextStyle,
                                          textScaleFactor: geTextScale(),
                                        ),
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          )),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  primaryColor),
                                          padding: MaterialStateProperty.all<
                                                  EdgeInsets>(
                                              EdgeInsets.symmetric(
                                                  horizontal:
                                                      getProportionateScreenWidth(
                                                          60),
                                                  vertical:
                                                      getProportionateScreenHeight(
                                                          15))),
                                        )),
                                  ))
                              : Container()
                        ],
                      )
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
                return Center(child: Text(state.error));
              } else {
                return Container();
              }
            }),
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
}
