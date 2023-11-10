import 'dart:async';
import 'dart:io';

import 'package:entekaravendor/constants/constants.dart';
import 'package:entekaravendor/pages/Signup/view/signup_screen.dart';
import 'package:entekaravendor/pages/location_details/view/google_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart' as l;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class LocationDetails extends StatefulWidget {
  const LocationDetails({Key? key}) : super(key: key);

  @override
  State<LocationDetails> createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  var uid;
  PlaceApiProvider? apiClient;

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
  }

  @override
  void initState() {
    markers.add(Marker(
      //add marker on google map
      markerId: MarkerId(showLocation.toString()),
      position: showLocation, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'My Custom Title ',
        snippet: 'My Custom Subtitle',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    //you can add more markers here
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
              zoomControlsEnabled: false,
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
              },
              initialCameraPosition: CameraPosition(
                target: initPos,
                zoom: 17.4746,
              ),
              mapType: MapType.normal,
            ),
    );
  }

  void fetchAddressDetail(LatLng location) async {
    List<l.Placemark> placemarks =
        await l.placemarkFromCoordinates(location.latitude, location.longitude);
    setState(() {
      addressTitle = placemarks[0].name!;
      locality = placemarks[0].locality!;
      city = placemarks[0].street!;
      pincode = placemarks[0].postalCode!;
      state = placemarks[0].administrativeArea!;
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
        child: SingleChildScrollView(
          child: Stack(
            children: [
              renderMap(),
              Positioned(
                  top: 30.sp,
                  left: 16.sp,
                  right: 16.sp,
                  child: Form(
                    key: _formKey,
                    child: TypeAheadFormField(
                      textFieldConfiguration: TextFieldConfiguration(
                          controller: searchController,
                          // autofocus: true,
                          style:
                              TextStyle(fontSize: 12.sp, color: primaryColor),
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
                      },
                      hideOnError: true,
                    ),
                  )),
              Positioned(
                  // top: constraints.constrainHeight() / 2 - 30,
                  bottom: MediaQuery.of(context).size.height > 1000
                      ? (MediaQuery.of(context).size.height - 100) / 2
                      : (MediaQuery.of(context).size.height) / 2 - 65,
                  left: MediaQuery.of(context).size.width > 600
                      ? MediaQuery.of(context).size.width / 2 - 20
                      : MediaQuery.of(context).size.width / 2 - 17,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 35,
                  )),
              Positioned(
                top: 450.sp,
                left: 100.sp,
                right: 100.sp,
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
                      height: 40,
                      width: 180,
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
                                fontFamily: "Sans",
                                fontWeight: FontWeight.w600,
                                letterSpacing: .2,
                                fontSize: 13,
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
                  top: 510.sp,
                  left: 0.sp,
                  right: 0.sp,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0)),
                      color: backgroundColor,
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(16.0.sp),
                          padding: EdgeInsets.all(16.0.sp),
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
                              heightSpace10,
                              Text(
                                'Selected address is:',
                                style: Text12TextStyle,
                                textScaleFactor: textFactor,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 8.0.sp, right: 8.0.sp),
                                child: Text(
                                  '$addressTitle,$locality,$city,$state,$pincode',
                                  style: Text9TextStyle,
                                  textScaleFactor: textFactor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        heightSpace30,
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen(
                                          lattitide: lat,
                                          longitude: lon,
                                        )),
                              );
                            },
                            child: Text(
                              'Save Location',
                              style: button16TextStyle,
                              textScaleFactor: textFactor,
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0.sp),
                              )),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  primaryColor),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.symmetric(
                                      horizontal: 110.sp, vertical: 15.sp)),
                            )),
                        heightSpace30
                      ],
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

  void initializeData() {
    setState(() {
      var uuid = Uuid();
      uid = uuid.v4();
    });
  }
}
