import 'package:cached_network_image/cached_network_image.dart';
import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/model/advertisement_model.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:entekaravendor/widgets/backbutton.dart';
import 'package:flutter/material.dart';

class AdvertisementDetails extends StatefulWidget {
  const AdvertisementDetails({Key? key, this.advData}) : super(key: key);
  final AdvertisementModel? advData;

  @override
  State<AdvertisementDetails> createState() => _AdvertisementDetailsState();
}

class _AdvertisementDetailsState extends State<AdvertisementDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(getProportionateScreenHeight(50)),
          child: backAppbar(context)),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: widget.advData!.image != null
                    ? CachedNetworkImage(
                        placeholder: (context, url) => Padding(
                            padding: EdgeInsets.all(
                                getProportionateScreenHeight(30)),
                            child: const CircularProgressIndicator()),
                        imageUrl: '${widget.advData!.image}',
                      )
                    : Image.asset(
                        "assets/images/noimage.jpeg",
                        height: getProportionateScreenHeight(360),
                        width: getProportionateScreenWidth(360),
                        fit: BoxFit.cover,
                      ),
              ),
              heightSpace40,
              Text(
                '${widget.advData!.title}',
                style: Text24STextStyle,
                textScaleFactor: geTextScale(),
              ),
              heightSpace20,
              Text(
                convertHtmlToString(widget.advData!.content),
                style: Text12bTextStyle,
                textScaleFactor: geTextScale(),
                textAlign: TextAlign.justify,
              ),
              heightSpace40,
            ],
          ),
        )),
      ),
    );
  }

  String convertHtmlToString(String? variantDescription) {
    String convertValue = "";
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return variantDescription!.replaceAll(exp, "").trim();
  }
}
