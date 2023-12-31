import 'package:cached_network_image/cached_network_image.dart';
import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/Dashboard/bloc/dashboard_bloc.dart';
import 'package:entekaravendor/pages/category/view/category_details.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:entekaravendor/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

class YourCategory extends StatefulWidget {
  const YourCategory({Key? key}) : super(key: key);

  @override
  State<YourCategory> createState() => _YourCategoryState();
}

class _YourCategoryState extends State<YourCategory>
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
          child: commonAppbar("Your Category", context)),
      body: BlocProvider(
        create: (context) => DashboardBloc()..add(FetchYourCategory(vendorId)),
        child: BlocListener<DashboardBloc, DashboardState>(
          listener: (context, state) {
            if (state is DeleteCategoryLoadedState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text("Category deleted successfully !!"),
                duration: const Duration(seconds: 4),
                action: SnackBarAction(
                  label: '',
                  onPressed: () {},
                ),
              ));
              context.read<DashboardBloc>().add(FetchYourCategory(vendorId));
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
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(16),
                  right: getProportionateScreenWidth(16),
                  top: getProportionateScreenHeight(5)),
              child: Column(
                children: [
                  BlocBuilder<DashboardBloc, DashboardState>(
                      builder: (context, state) {
                    if (state is CategoryLoadingState) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: primaryColor,
                      ));
                    } else if (state is YourCategoryLoadedState) {
                      return Expanded(
                          flex: 10,
                          child: state.categoryDataList!.data!.length > 0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      state.categoryDataList!.data!.length,
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
                                          border: Border.all(color: greyColor),
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
                                                              .categoryDataList!
                                                              .data![index]
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
                                                              '${state.categoryDataList!.data![index].image}',
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
                                                "${state.categoryDataList!.data![index].name}",
                                                style: Product16TextStyle,
                                                textScaleFactor: geTextScale(),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: InkWell(
                                                    onTap: () {
                                                      context
                                                          .read<DashboardBloc>()
                                                          .add(DeleteCategory(
                                                              vendorId,
                                                              state
                                                                  .categoryDataList!
                                                                  .data![index]
                                                                  .id!));
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
                                                        color: Colors.red,
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.delete_rounded,
                                                          color: Colors.white,
                                                          size:
                                                              getProportionateScreenHeight(
                                                                  20),
                                                        ),
                                                      ),
                                                    )))
                                          ],
                                        ));
                                  })
                              : Expanded(
                                  flex: 10,
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        'No Data Found',
                                        style: button16BTextStyle,
                                        textScaleFactor: geTextScale(),
                                      ),
                                    ),
                                  ),
                                ));
                    } else if (state is ErrorState) {
                      return Expanded(
                          flex: 10, child: Center(child: Text(state.error)));
                    } else {
                      return Container();
                    }
                  }),
                  Expanded(
                      flex: 1,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CategoryDetails()));
                          },
                          child: Container(
                            height: getProportionateScreenHeight(30),
                            width: getProportionateScreenWidth(182),
                            padding: EdgeInsets.only(
                              // left: getProportionateScreenWidth(10),
                              top: getProportionateScreenHeight(5),
                              // right: getProportionateScreenWidth(10),
                              bottom: getProportionateScreenHeight(5),
                            ),
                            decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Center(
                              child: Text(
                                'Add Category',
                                style: Text12TextTextStyle,
                                textScaleFactor: geTextScale(),
                              ),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
