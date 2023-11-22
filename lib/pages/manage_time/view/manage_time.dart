import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/manage_time/bloc/manage_timing_bloc.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:entekaravendor/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final _formKey = GlobalKey<FormState>();
  int vendorId = 0;
  final storage = GetStorage();

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
          child: commonAppbar("Manage Time", context)),
      body: BlocProvider(
        create: (context) => ManageTimingBloc()..add(FetchDays()),
        child: SafeArea(
          child: BlocListener<ManageTimingBloc, ManageTimingState>(
            listener: (context, state) {
              if (state is AddWorkingDaysLoadedState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Container(
                      height: getProportionateScreenHeight(40),
                      child: Text("Data added successfully !!")),
                  duration: const Duration(seconds: 4),
                  action: SnackBarAction(
                    label: '',
                    onPressed: () {},
                  ),
                ));
                context.read<ManageTimingBloc>().add(FetchDays());
              } else if (state is ErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Container(
                      height: getProportionateScreenHeight(40),
                      child: Text("${state.error}")),
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
                if (state is DaysLoadedState) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: getProportionateScreenHeight(20),
                        bottom: getProportionateScreenHeight(8),
                        left: getProportionateScreenWidth(20),
                        right: getProportionateScreenWidth(20)),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          dropDown(
                              'Vendor Type*',
                              state.dayData!.data![0].dayTitle!,
                              type, (String? newValue) {
                            setState(() {
                              type = newValue!;
                              print("new value= $newValue");
                              day_id = newValue!;
                            });
                          }, state.dayData!.data!),
                          heightSpace20,
                          TextFormField(
                            cursorColor: primaryColor,
                            enabled: true,
                            onTap: () {
                              _selectOpenTime(context);
                            },
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: getProportionateScreenHeight(12)),
                            decoration: new InputDecoration(
                              prefixIcon: Icon(Icons.access_time),
                              labelText: "Open Time",
                              labelStyle: TextStyle(
                                  fontSize: getProportionateScreenHeight(14)),
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
                                fontSize: getProportionateScreenHeight(12)),
                            decoration: new InputDecoration(
                              prefixIcon: Icon(Icons.access_time),
                              labelText: "Close Time",
                              labelStyle: TextStyle(
                                  fontSize: getProportionateScreenHeight(14)),
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
                            controller: closeTimeController,
                            keyboardType: TextInputType.text,
                            validator: (name) {
                              if (name == "") {
                                return 'Close is required.';
                              }
                              return null;
                            },
                          ),
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
                                          openTimeController.text));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Container(
                                        height:
                                            getProportionateScreenHeight(40),
                                        child: Text("All Field Required !!")),
                                    duration: const Duration(seconds: 4),
                                    action: SnackBarAction(
                                      label: '',
                                      onPressed: () {},
                                    ),
                                  ));
                                }
                              },
                              child: Container(
                                height: getProportionateScreenHeight(38),
                                width: getProportionateScreenWidth(182),
                                padding: EdgeInsets.only(
                                  // left: getProportionateScreenWidth(10),
                                  top: getProportionateScreenHeight(8),
                                  // right: getProportionateScreenWidth(10),
                                  bottom: getProportionateScreenHeight(8),
                                ),
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Center(
                                  child: Text(
                                    'Manage Time',
                                    style: button16TextStyle,
                                    textScaleFactor: textFactor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
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
}
