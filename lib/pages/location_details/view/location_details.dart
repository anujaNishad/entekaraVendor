import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/Signup/view/signup_screen.dart';
import 'package:entekaravendor/pages/location_details/view/google_place.dart';
import 'package:entekaravendor/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart' as l;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class LocationDetails extends StatefulWidget {
  const LocationDetails({Key? key, this.userId, this.phoneNumber})
      : super(key: key);
  final int? userId;
  final String? phoneNumber;

  @override
  State<LocationDetails> createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  var uid;
  PlaceApiProvider? apiClient;
  DateTime? currentBackPressTime;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isSearching = false;
  List<Suggestion> searchresult = [];
  GoogleMapController? mapController; //contrller for Google map
  Set<Marker> markers = Set(); //markers for google map
  LatLng showLocation = LatLng(27.7089427, 85.3086209);
  //location to show in map
  final TextEditingController searchController = new TextEditingController();
  StreamController<LatLng> streamController = StreamController();
  LatLng? markerPos;
  LatLng initPos = LatLng(9.9894, 76.5790);
  double lat = 0.9894;
  double lon = 76.5790;
  String location = "";
  bool loadingMap = false;
  bool init = true;
  bool loadingAddressDetails = false;
  String addressTitle = '';
  String locality = '';
  String city = '';
  String state = '';
  String district = '';
  String pincode = '';

  String apiKey() {
    if (Platform.isAndroid) {
      // Android-specific code
      String apiKey = "AIzaSyBQEuGvLDmMkzMGivzm9pamyxmPHdz_vvo";
      return apiKey;
    } else if (Platform.isIOS) {
      // iOS-specific code
      String apiKey = "AIzaSyBQEuGvLDmMkzMGivzm9pamyxmPHdz_vvo";
      return apiKey;
    } else
      return "";
  }

  getCurrentLoc() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    initPos = LatLng(position.latitude, position.longitude);
    print("current loc=$initPos");
    streamController.add(initPos);
    setState(() {
      loadingMap = false;
      initPos = LatLng(position.latitude, position.longitude);
      lat = position.latitude;
      lon = position.longitude;
      print("current loc=$initPos");
      streamController.add(initPos);
    });
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/logo.png', 50);
    markers.add(Marker(
        onTap: () {
          print('Tapped');
        },
        icon: BitmapDescriptor.fromBytes(markerIcon),
        /*await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(50, 50)), 'assets/images/logo.png'),*/
        draggable: true,
        markerId: MarkerId('Marker'),
        position: LatLng(position.latitude, position.longitude),
        onDragEnd: ((newPosition) {
          print(newPosition.latitude);
          print(newPosition.longitude);
        })));
  }

  Future getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadingMap = true;
    getCurrentLoc();
    initializeData();
  }

  @override
  void dispose() {
    super.dispose();
    mapController!.dispose();
    streamController.close();
  }

  renderMap() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: (loadingMap)
          ? const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
              myLocationEnabled: true,
              buildingsEnabled: true,
              indoorViewEnabled: false,
              onMapCreated: (controller) {
                mapController = controller;
                setState(() {
                  fetchAddressDetail(initPos);
                });
              },
              onCameraIdle: () {
                fetchAddressDetail(LatLng(lat, lon));
              },
              onCameraMove: (CameraPosition pos) {
                streamController.add(pos.target);
                setState(() async {
                  final Uint8List markerIcon =
                      await getBytesFromAsset('assets/images/logo.png', 50);
                  markers.add(Marker(
                      onTap: () {
                        print('Tapped');
                      },
                      draggable: true,
                      icon: BitmapDescriptor.fromBytes(markerIcon),
                      markerId: MarkerId('Marker'),
                      position: pos.target,
                      onDragEnd: ((newPosition) {
                        print(newPosition.latitude);
                        print(newPosition.longitude);
                      })));
                  fetchAddressDetail(pos.target);
                });
              },
              initialCameraPosition: CameraPosition(
                target: initPos,
                zoom: 17.4746,
              ),
              mapType: MapType.normal,
              markers: markers,
            ),
    );
  }

  void fetchAddressDetail(LatLng location) async {
    List<l.Placemark> placemarks =
        await l.placemarkFromCoordinates(location.latitude, location.longitude);
    setState(() {
      addressTitle = placemarks[0].locality!;
      locality = placemarks[0].subLocality!;
      city = placemarks[0].street!;
      pincode = placemarks[0].postalCode!;
      state = placemarks[0].administrativeArea!;
      district = placemarks[0].subAdministrativeArea!;
      print("dis=${placemarks[0]}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textColor,
      /* appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Location Details",
          style: appbarTextStyle,
          textScaleFactor: textFactor,
        ),
      ),*/
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            bool backStatus = onWillPop();
            if (backStatus) {
              exit(0);
            }
            return false;
          },
          child: Stack(
            children: [
              renderMap(),
              Positioned(
                  top: getProportionateScreenHeight(30),
                  left: getProportionateScreenWidth(16),
                  right: getProportionateScreenWidth(16),
                  child: Form(
                    key: _formKey,
                    child: TypeAheadFormField(
                      textFieldConfiguration: TextFieldConfiguration(
                          controller: searchController,
                          // autofocus: true,
                          style: TextStyle(
                              fontSize: getProportionateScreenHeight(12),
                              color: primaryColor),
                          decoration: InputDecoration(
                              hintText: "Search for location",
                              hintStyle: TextStyle(color: primaryColor),
                              fillColor: backgroundColor,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.search_outlined,
                                color: primaryColor,
                              ),
                              border: OutlineInputBorder())),
                      //searchresult
                      suggestionsCallback: (pattern) async {
                        setState(() {
                          lat = 0.0;
                          lon = 0.0;
                        });
                        if (pattern != "")
                          return await searchLocation(pattern);
                        else
                          return [];
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          leading: Icon(Icons.location_on),
                          title: Text("${suggestion.description}"),
                          subtitle: Text("${suggestion.detailDescription}"),
                        );
                      },
                      onSuggestionSelected: (suggestion) async {
                        final placeDetails = await PlaceApiProvider(uid)
                            .getPlaceDetailFromId(suggestion.placeId);
                        setState(() {
                          lat = placeDetails.lattitude;
                          lon = placeDetails.longitude;
                          var newlatlang = LatLng(lat, lon);
                          searchController.text = suggestion.detailDescription;
                        });
                        var newlatlang = LatLng(lat, lon);
                        mapController?.animateCamera(
                            CameraUpdate.newCameraPosition(
                                CameraPosition(target: newlatlang, zoom: 17)));

                        setState(() async {
                          final Uint8List markerIcon = await getBytesFromAsset(
                              'assets/images/logo.png', 50);
                          markers.add(Marker(
                              onTap: () {
                                print('Tapped');
                              },
                              draggable: true,
                              icon: BitmapDescriptor.fromBytes(markerIcon),
                              markerId: MarkerId('Marker'),
                              position: LatLng(
                                  newlatlang.latitude, newlatlang.longitude),
                              onDragEnd: ((newPosition) {
                                print(newPosition.latitude);
                                print(newPosition.longitude);
                              })));
                        });
                      },
                      hideOnError: true,
                    ),
                  )),
              Positioned(
                top: getProportionateScreenHeight(490),
                left: getProportionateScreenWidth(100),
                right: getProportionateScreenWidth(100),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      mapController!
                          .animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                          bearing: 0,
                          target: LatLng(initPos.latitude, initPos.longitude),
                          zoom: 17.0,
                        ),
                      ));
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFF002434), width: 2),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white),
                      height: getProportionateScreenHeight(40),
                      width: getProportionateScreenWidth(180),
                      child: Center(
                          child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.location_searching_outlined,
                              color: primaryColor,
                            ),
                            Text(
                              "Use current location",
                              style: TextStyle(
                                color: primaryColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                letterSpacing: .2,
                                fontSize: getProportionateScreenHeight(13),
                                fontStyle: FontStyle.normal,
                              ),
                              textScaleFactor: 1,
                            ),
                          ],
                        ),
                      ))),
                ),
              ),
              Positioned(
                  top: getProportionateScreenHeight(560),
                  left: getProportionateScreenWidth(0),
                  right: getProportionateScreenWidth(0),
                  bottom: getProportionateScreenHeight(0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0)),
                      color: backgroundColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(getProportionateScreenHeight(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          heightSpace20,
                          Center(
                            child: Container(
                              width: getProportionateScreenWidth(330),
                              padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(16),
                                  right: getProportionateScreenWidth(16),
                                  top: getProportionateScreenHeight(20),
                                  bottom: getProportionateScreenHeight(20)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  topLeft: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                ),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Selected address is:',
                                    style: Text12TextStyle,
                                    textScaleFactor: geTextScale(),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: getProportionateScreenWidth(8),
                                        right: getProportionateScreenWidth(8)),
                                    child: Text(
                                      '$addressTitle,$locality,$city,$state,$pincode',
                                      style: Text9TextStyle,
                                      textScaleFactor: geTextScale(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          heightSpace30,
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupScreen(
                                            lattitide: lat,
                                            longitude: lon,
                                            userId: widget.userId,
                                            phoneNumber: widget.phoneNumber,
                                            district: district,
                                            locality: addressTitle,
                                            pincode: pincode,
                                            state: state,
                                          )),
                                );
                              },
                              child: Container(
                                height: getProportionateScreenHeight(38),
                                width: getProportionateScreenWidth(182),
                                padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(40),
                                  top: getProportionateScreenHeight(8),
                                  right: getProportionateScreenWidth(40),
                                  bottom: getProportionateScreenHeight(8),
                                ),
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Center(
                                  child: Text(
                                    'Save Location',
                                    style: button16TextStyle,
                                    textScaleFactor: geTextScale(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
  /*
  mapController?.animateCamera(
                            CameraUpdate.newCameraPosition(
                                CameraPosition(target: newlatlang, zoom: 17)));

   */

  Future<List<Suggestion>> searchLocation(String text) async {
    print("search example");
    searchresult.clear();
    setState(() {
      isSearching = true;
    });

    apiClient = PlaceApiProvider(uid);

    dynamic lat1 = 0.0, lng1 = 0.0;
    // List<Suggestion> list;
    /* var res=await apiClient
        .fetchSuggestions(
        text, Localizations.localeOf(context).languageCode)
        .then((response) async {
      list = response;
      print("Search Result=${searchresult}");
      setState(() {
        isSearching=false;
      });
    });*/
    List<Suggestion> list = await apiClient!
        .fetchSuggestions(text, Localizations.localeOf(context).languageCode);
    return Future.value(list);
  }

  Future<void> initializeData() async {
    setState(() {
      var uuid = Uuid();
      uid = uuid.v4();
    });
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/logo.png', 50);
    markers.add(Marker(
        onTap: () {
          print('Tapped');
        },
        draggable: true,
        icon: BitmapDescriptor.fromBytes(markerIcon),
        markerId: MarkerId('Marker'),
        position: LatLng(initPos.latitude, initPos.longitude),
        onDragEnd: ((newPosition) {
          print(newPosition.latitude);
          print(newPosition.longitude);
        })));
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }
}
