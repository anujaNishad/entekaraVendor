import 'dart:convert';
import 'dart:io';

import 'package:entekaravendor/constants/constants.dart';
import 'package:http/http.dart';

class Place {
  dynamic lattitude;
  dynamic longitude;

  Place({
    this.lattitude,
    this.longitude,
  });
}

class Suggestion {
  final String placeId;
  final String description;
  final String detailDescription;

  Suggestion(this.placeId, this.description, this.detailDescription);
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  static final String androidKey = googleAPIKey;
  static final String iosKey = googleAPIKey;
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    //final request = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:in&key=$apiKey&sessiontoken=$sessionToken';
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey&sessiontoken=$sessionToken&components=country:in';

    print("requestapi=${request}");
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      List<Suggestion> SuggessionList = [];
      print("Cb1");
      Map<String, dynamic> result = {};
      try {
        print(json.decode(response.body));
        result = json.decode(response.body);
        print("Cb2");
      } catch (e) {
        print("error : ${e.toString()}");
      }
      if (result['status'] == 'OK') {
        try {
          List<dynamic> temp = result["predictions"];
          temp.forEach((element) {
            Map<dynamic, dynamic> loc = element["structured_formatting"];
            String locationName = loc["main_text"];
            SuggessionList.add(Suggestion(
                element["place_id"], loc["main_text"], element["description"]));
          });
        } catch (e) {
          print(e);
          // TODO
        }

        return SuggessionList;
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    //'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$apiKey&sessiontoken=$sessionToken';
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';

    print("place details=${request}");
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      List<Place> locationDetails = [];
      if (result['status'] == 'OK') {
        Map<dynamic, dynamic> loc = result['result']['geometry']['location'];
        dynamic latti = loc["lat"];
        dynamic longi = loc["lng"];
        final place = Place();
        place.lattitude = latti;
        place.longitude = longi;
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
