import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/model/GetManageTimeModel.dart';
import 'package:entekaravendor/model/day_model.dart' as days;
import 'package:entekaravendor/pages/manage_time/bloc/manage_timing_bloc.dart';
import 'package:entekaravendor/pages/manage_time/data/manage_timing_api.dart';
import 'package:entekaravendor/services/failure.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:entekaravendor/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class ManageTimingScreen extends StatefulWidget {
  const ManageTimingScreen({Key? key}) : super(key: key);

  @override
  State<ManageTimingScreen> createState() => _ManageTimingScreenState();
}

class _ManageTimingScreenState extends State<ManageTimingScreen> {
  String? type;
  String? day_id;
  final TextEditingController openTimeController = new TextEditingController();
  final TextEditingController closeTimeController = new TextEditingController();
  final ManageTimingApi _manageTimingApi = ManageTimingApi();
  final _formKey = GlobalKey<FormState>();
  int vendorId = 0;
  bool isOpen = true,
      isClose = false,
      isLoading = false,
      isManageLoading = false;
  String status = 'open';
  final storage = GetStorage();
  GetManageTimeModel? getManageTimeModel;
  days.DaysModel? daysModel;
  List<days.Datum> dayList = [];
  List<days.Datum> dayList1 = [];
  List<days.Datum> dayDetails = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vendorId = int.parse(storage.read("vendorId").toString());
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(getProportionateScreenHeight(50)),
          child: commonAppbar("Add Time", context)),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ManageTimingBloc(),
          child: BlocListener<ManageTimingBloc, ManageTimingState>(
            listener: (context, state) {
              if (state is AddWorkingDaysLoadedState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Data added successfully !!"),
                  duration: const Duration(seconds: 4),
                  action: SnackBarAction(
                    label: '',
                    onPressed: () {},
                  ),
                ));

                initializeData();
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
                return Padding(
                  padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(20),
                      bottom: getProportionateScreenHeight(8),
                      left: getProportionateScreenWidth(20),
                      right: getProportionateScreenWidth(20)),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : dayList.length > 0
                                ? Container(
                                    height: 50,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: fixPadding,
                                      vertical: fixPadding / 2,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xFFE1DFDD), width: 1),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        isExpanded: true,
                                        elevation: 0,
                                        isDense: true,
                                        hint: Text(
                                          dayList[0].dayTitle!,
                                          style: grey15RegularTextStyle,
                                        ),
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: primaryColor,
                                          size: 20,
                                        ),
                                        value: type,
                                        style: black14SemiBoldTextStyle,
                                        onChanged: (newValue) {
                                          setState(() {
                                            type = newValue;
                                            day_id = newValue;
                                          });
                                        },
                                        items: dayList.map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value.id.toString(),
                                            child: Text(value.dayTitle!),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  )
                                : Container(),
                        heightSpace20,
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isOpen = true;
                                  isClose = false;
                                  status = "open";
                                });
                              },
                              child: Container(
                                width: getProportionateScreenWidth(100),
                                height: getProportionateScreenHeight(50),
                                padding: EdgeInsets.only(
                                    left: getProportionateScreenWidth(16),
                                    right: getProportionateScreenWidth(16),
                                    top: getProportionateScreenHeight(10),
                                    bottom: getProportionateScreenHeight(10)),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(9.0)),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: isOpen == true
                                            ? primaryColor
                                            : Colors.white)),
                                child: Center(
                                  child: Text(
                                    'Open',
                                    style: TextStyle(
                                      color: isOpen == true
                                          ? primaryColor
                                          : secondColor,
                                      fontSize:
                                          getProportionateScreenHeight(12),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Oxygen",
                                    ),
                                    textScaleFactor: geTextScale(),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isClose = true;
                                  isOpen = false;
                                  status = "close";
                                });
                              },
                              child: Container(
                                width: getProportionateScreenWidth(100),
                                height: getProportionateScreenHeight(50),
                                padding: EdgeInsets.only(
                                    left: getProportionateScreenWidth(16),
                                    right: getProportionateScreenWidth(16),
                                    top: getProportionateScreenHeight(10),
                                    bottom: getProportionateScreenHeight(10)),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(9.0)),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: isClose
                                            ? primaryColor
                                            : Colors.white)),
                                child: Center(
                                  child: Text(
                                    'Close',
                                    style: TextStyle(
                                      color:
                                          isClose ? primaryColor : secondColor,
                                      fontSize:
                                          getProportionateScreenHeight(12),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Oxygen",
                                    ),
                                    textScaleFactor: geTextScale(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        status == "open"
                            ? Column(
                                children: [
                                  heightSpace20,
                                  TextFormField(
                                    cursorColor: primaryColor,
                                    enabled: true,
                                    onTap: () {
                                      _selectOpenTime(context);
                                    },
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            getProportionateScreenHeight(12)),
                                    decoration: new InputDecoration(
                                      prefixIcon: Icon(Icons.access_time),
                                      labelText: "Open Time",
                                      labelStyle: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(14)),
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
                                    controller: openTimeController,
                                    keyboardType: TextInputType.text,
                                    validator: (name) {
                                      if (name == "") {
                                        return 'Open Time is required.';
                                      }
                                      return null;
                                    },
                                  ),
                                  heightSpace20,
                                  TextFormField(
                                    enabled: true,
                                    onTap: () {
                                      _selectCloseTime(context);
                                    },
                                    cursorColor: primaryColor,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            getProportionateScreenHeight(12)),
                                    decoration: new InputDecoration(
                                      prefixIcon: Icon(Icons.access_time),
                                      labelText: "Close Time",
                                      labelStyle: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(14)),
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
                                    controller: closeTimeController,
                                    keyboardType: TextInputType.text,
                                    validator: (name) {
                                      if (name == "") {
                                        return 'Close is required.';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              )
                            : Container(),
                        heightSpace20,
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<ManageTimingBloc>().add(
                                    AddWorkingDays(
                                        vendorId,
                                        int.parse(day_id!),
                                        closeTimeController.text,
                                        openTimeController.text,
                                        status));
                                setState(() {
                                  dayList.clear();
                                });
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("All Field Required !!"),
                                  duration: const Duration(seconds: 4),
                                  action: SnackBarAction(
                                    label: '',
                                    onPressed: () {},
                                  ),
                                ));
                              }
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
                                  'Save Time',
                                  style: Text12TextTextStyle,
                                  textScaleFactor: textFactor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        heightSpace60,
                        Text(
                          'Manage Time Details',
                          style: black16BoldTextStyle,
                          textScaleFactor: textFactor,
                        ),
                        heightSpace20,
                        Expanded(
                            child: getManageTimeModel != null
                                ? getManageTimeModel!.data!.length > 0
                                    ? Column(
                                        children: [
                                          Expanded(
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: getManageTimeModel!
                                                    .data!.length,
                                                itemBuilder: (context, index) {
                                                  return Container(
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
                                                              color: greyColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.white),
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
                                                                        flex: 6,
                                                                        child:
                                                                            Text(
                                                                          "${getManageTimeModel!.data![index].dayTitle}",
                                                                          style:
                                                                              Product16TextStyle,
                                                                          textScaleFactor:
                                                                              geTextScale(),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Text(
                                                                          "${getManageTimeModel!.data![index].status}",
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
                                                                        getManageTimeModel!.data![index].openingTime ==
                                                                                null
                                                                            ? 'Open Time:00:00'
                                                                            : 'Open Time:${getManageTimeModel!.data![index].openingTime}',
                                                                        style:
                                                                            Text12boldTextStyle,
                                                                        textScaleFactor:
                                                                            geTextScale(),
                                                                      ),
                                                                      Text(
                                                                        getManageTimeModel!.data![index].closingTime ==
                                                                                null
                                                                            ? 'Close Time:00:00'
                                                                            : "Close Time:${getManageTimeModel!.data![index].closingTime} ",
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
                                                      ));
                                                }),
                                          ),
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
                                      )
                                : Container())
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  dropDown(String heading, String hint, String? assignedTo,
      void Function(String?)? onChanged, List data) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(
        horizontal: fixPadding,
        vertical: fixPadding / 2,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE1DFDD), width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          elevation: 0,
          isDense: true,
          hint: Text(
            hint,
            style: grey15RegularTextStyle,
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: primaryColor,
            size: 20,
          ),
          value: assignedTo,
          style: black14SemiBoldTextStyle,
          onChanged: onChanged,
          items: data.map((value) {
            return DropdownMenuItem<String>(
              value: value.id.toString(),
              child: Text(value.dayTitle),
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> _selectCloseTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      String selTime =
          picked.hour.toString() + ':' + picked.minute.toString() + ':00';
      setState(() {
        closeTimeController.text =
            DateFormat.jm().format(DateFormat("hh:mm:ss").parse(selTime));
      });
    }
  }

  Future<void> _selectOpenTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      String selTime =
          picked.hour.toString() + ':' + picked.minute.toString() + ':00';
      setState(() {
        openTimeController.text =
            DateFormat.jm().format(DateFormat("hh:mm:ss").parse(selTime));
      });
    }
  }

  Future<void> getDropDown() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await _manageTimingApi.getWorkingDays();
      if (response["message"] == "Success") {
        setState(() {
          daysModel = days.DaysModel.fromJson(response);
        });
      } else if (response["message"] != "Success") {
        Fluttertoast.showToast(msg: response["message"]);
      } else {
        Fluttertoast.showToast(msg: response["errmessage"]);
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getManageDetails() async {
    dayDetails.clear();
    dayList.clear();
    setState(() {
      isManageLoading = true;
    });
    try {
      final response = await _manageTimingApi.getWorkingDetails(vendorId);
      if (response["message"] == "Success") {
        setState(() {
          getManageTimeModel = GetManageTimeModel.fromJson(response);
          getManageTimeModel!.data!.forEach((element) {
            days.Datum d1 =
                days.Datum(id: element.dayId, dayTitle: element.dayTitle);
            dayDetails.addAll([d1]);
          });

          dayDetails.sort((a, b) => a.id!.compareTo(b.id!));
        });
        getDays();
      } else if (response["message"] != "Success") {
        Fluttertoast.showToast(msg: response["message"]);
      } else {
        Fluttertoast.showToast(msg: response["errmessage"]);
      }
      setState(() {
        isManageLoading = false;
      });
    } on NetworkException {
      setState(() {
        isManageLoading = false;
      });
    } catch (e) {
      setState(() {
        isManageLoading = false;
      });
    }
  }

  void initializeData() {
    getDropDown();
    getManageDetails();
  }

  getDays() {
    setState(() {
      dayList.clear();
    });

    dayDetails.forEach((element) {
      daysModel!.data!.forEach((element1) {
        if (element1.dayTitle == element.dayTitle) {
          print("${element1.dayTitle}");
          setState(() {
            element1.isSelect = true;
          });
        }
      });
    });
    daysModel!.data!
      ..forEach((element) {
        if (element.isSelect == false) {
          setState(() {
            dayList.add(element);
          });
        }
      });

    type = dayList[0].id.toString();
    print("dayList =${dayList.length}");
    print("dayList1 =${dayList1.length}");
  }
}
