import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/manage_time/bloc/manage_timing_bloc.dart';
import 'package:entekaravendor/pages/manage_time/view/Edit_manage_time.dart';
import 'package:entekaravendor/pages/manage_time/view/manage_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_storage/get_storage.dart';

import '../../../util/size_config.dart';

class ManageTimeDetails extends StatefulWidget {
  const ManageTimeDetails({Key? key}) : super(key: key);

  @override
  State<ManageTimeDetails> createState() => _ManageTimeDetailsState();
}

class _ManageTimeDetailsState extends State<ManageTimeDetails> {
  int vendorId = 0;
  final storage = GetStorage();
  int length = 0;

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
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios_new_outlined),
              ),
              centerTitle: true,
              title: Text(
                "Manage Time Details",
                style: appbarTextStyle,
                textScaleFactor: geTextScale(),
              ),
            )),
        body: BlocProvider(
            create: (context) =>
                ManageTimingBloc()..add(GetManageData(vendorId)),
            child: SafeArea(
              child: BlocListener<ManageTimingBloc, ManageTimingState>(
                listener: (context, state) {
                  if (state is DeleteWorkingDaysLoadedState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Deleted successfully !!"),
                      duration: const Duration(seconds: 4),
                      action: SnackBarAction(
                        label: '',
                        onPressed: () {},
                      ),
                    ));
                    context
                        .read<ManageTimingBloc>()
                        .add(GetManageData(vendorId));
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
                child: BlocBuilder<ManageTimingBloc, ManageTimingState>(
                  builder: (context, state) {
                    print("fetch=${state.isFetching}");
                    return Padding(
                      padding: EdgeInsets.only(
                          top: getProportionateScreenHeight(30)),
                      child: Stack(
                        children: [
                          heightSpace20,
                          if (state is ManageTimingLoadingState)
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          state.manageTimeModel != null
                              ? state.manageTimeModel!.data!.length > 0
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          left: getProportionateScreenWidth(16),
                                          right:
                                              getProportionateScreenWidth(16),
                                          bottom:
                                              getProportionateScreenHeight(60)),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              context
                                                  .read<ManageTimingBloc>()
                                                  .add(GetManageData(vendorId));
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text("Refresh"),
                                                Icon(Icons.refresh_outlined)
                                              ],
                                            ),
                                          ),
                                          heightSpace20,
                                          Expanded(
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: state
                                                    .manageTimeModel!
                                                    .data!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  length = state
                                                      .manageTimeModel!
                                                      .data!
                                                      .length;
                                                  print("length=$length");
                                                  return Slidable(
                                                    // Specify a key if the Slidable is dismissible.
                                                    key: const ValueKey(1),
                                                    // The end action pane is the one at the right or the bottom side.
                                                    endActionPane: ActionPane(
                                                      motion:
                                                          const ScrollMotion(),
                                                      dismissible:
                                                          DismissiblePane(
                                                              onDismissed: () {
                                                        context
                                                            .read<
                                                                ManageTimingBloc>()
                                                            .add(DeleteWorkingDays(
                                                                vendorId,
                                                                state
                                                                    .manageTimeModel!
                                                                    .data![
                                                                        index]
                                                                    .id!));
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
                                                                            EditManageTimingScreen(
                                                                              manageData: state.manageTimeModel!.data![index],
                                                                            )),
                                                              );
                                                            },
                                                            child: Container(
                                                              width:
                                                                  getProportionateScreenWidth(
                                                                      58),
                                                              height:
                                                                  getProportionateScreenHeight(
                                                                      58),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
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
                                                                      ManageTimingBloc>()
                                                                  .add(DeleteWorkingDays(
                                                                      vendorId,
                                                                      state
                                                                          .manageTimeModel!
                                                                          .data![
                                                                              index]
                                                                          .id!));
                                                            },
                                                            child: Container(
                                                              width:
                                                                  getProportionateScreenWidth(
                                                                      58),
                                                              height:
                                                                  getProportionateScreenHeight(
                                                                      58),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color:
                                                                      redColor),
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
                                                        padding:
                                                            EdgeInsets.only(
                                                                right:
                                                                    getProportionateScreenWidth(
                                                                  10,
                                                                ),
                                                                left:
                                                                    getProportionateScreenWidth(
                                                                  10,
                                                                ),
                                                                bottom:
                                                                    getProportionateScreenWidth(
                                                                  10,
                                                                )),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    greyColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                Colors.white),
                                                        child: Row(
                                                          children: [
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
                                                                          flex:
                                                                              6,
                                                                          child:
                                                                              Text(
                                                                            "${state.manageTimeModel!.data![index].dayTitle}",
                                                                            style:
                                                                                Product16TextStyle,
                                                                            textScaleFactor:
                                                                                geTextScale(),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text(
                                                                            "${state.manageTimeModel!.data![index].status}",
                                                                            style:
                                                                                Text10STextStyle,
                                                                            textScaleFactor:
                                                                                geTextScale(),
                                                                            textAlign:
                                                                                TextAlign.right,
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
                                                                          state.manageTimeModel!.data![index].openingTime == null
                                                                              ? 'Open Time:00:00'
                                                                              : 'Open Time:${state.manageTimeModel!.data![index].openingTime}',
                                                                          style:
                                                                              Text12boldTextStyle,
                                                                          textScaleFactor:
                                                                              geTextScale(),
                                                                        ),
                                                                        Text(
                                                                          state.manageTimeModel!.data![index].closingTime == null
                                                                              ? 'Close Time:00:00'
                                                                              : "Close Time:${state.manageTimeModel!.data![index].closingTime} ",
                                                                          style:
                                                                              Text12boldTextStyle,
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
                                                }),
                                          ),
                                        ],
                                      ))
                                  : Container(
                                      child: Center(
                                        child: Text(
                                          'No Data Found',
                                          style: button16BTextStyle,
                                          textScaleFactor: textFactor,
                                        ),
                                      ),
                                    )
                              : Center(
                                  child: CircularProgressIndicator(),
                                ),
                          if (state is ErrorState)
                            Center(
                              child: Text(state.error),
                            ),
                          state.isButton
                              ? Container()
                              : Positioned(
                                  bottom: getProportionateScreenHeight(10),
                                  left: getProportionateScreenWidth(80),
                                  right: getProportionateScreenWidth(80),
                                  child: length == 7
                                      ? Container()
                                      : GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ManageTimingScreen()),
                                            );
                                          },
                                          child: Container(
                                            height:
                                                getProportionateScreenHeight(
                                                    30),
                                            width: getProportionateScreenWidth(
                                                182),
                                            padding: EdgeInsets.only(
                                              //  left: getProportionateScreenWidth(10),
                                              top: getProportionateScreenHeight(
                                                  5),
                                              // right: getProportionateScreenWidth(10),
                                              bottom:
                                                  getProportionateScreenHeight(
                                                      5),
                                            ),
                                            decoration: BoxDecoration(
                                                color: backgroundColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            child: Center(
                                              child: Text(
                                                'Add Time Details',
                                                style: Text12TextTextStyle,
                                                textScaleFactor: textFactor,
                                              ),
                                            ),
                                          ),
                                        ))
                        ],
                      ),
                    );
                  },
                ),
              ),
            )));
  }
}
