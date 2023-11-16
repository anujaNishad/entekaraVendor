import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:entekaravendor/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class RequestDashboard extends StatefulWidget {
  const RequestDashboard({Key? key}) : super(key: key);

  @override
  State<RequestDashboard> createState() => _RequestDashboardState();
}

class _RequestDashboardState extends State<RequestDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(getProportionateScreenHeight(50)),
          child: commonAppbar("Request Dashboard", context)),
      body: SafeArea(
        child: Column(
          children: [
            heightSpace20,
            ListView.builder(
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Slidable(
                    // Specify a key if the Slidable is dismissible.
                    key: const ValueKey(1),
                    // The end action pane is the one at the right or the bottom side.
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(onDismissed: () {}),
                      children: const [
                        SlidableAction(
                          // An action can be bigger than the others.
                          flex: 2,
                          onPressed: doNothing,
                          backgroundColor: primaryColor,
                          foregroundColor: textColor,
                          icon: Icons.edit,
                          label: 'Edit',
                        ),
                        SlidableAction(
                          onPressed: doNothing,
                          backgroundColor: redColor,
                          foregroundColor: textColor,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: getProportionateScreenWidth(16),
                              right: getProportionateScreenWidth(16),
                              top: getProportionateScreenHeight(10)),
                          child: Text(
                            "Store Verification",
                            style: second16TextStyle,
                            textScaleFactor: textFactor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: getProportionateScreenWidth(16),
                              right: getProportionateScreenWidth(16),
                              top: getProportionateScreenHeight(10)),
                          child: Text(
                            "Under review",
                            style: second14TextStyle,
                            textScaleFactor: textFactor,
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}
