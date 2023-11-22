import 'dart:convert';
import 'dart:io';

import 'package:entekaravendor/constants/api_constatnt.dart';
import 'package:entekaravendor/model/signup_model.dart';
import 'package:entekaravendor/model/vendorType_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../../services/failure.dart';
import 'sign_up_api.dart';

class SignUpRepository {
  final SignUpApi _signUpApi = SignUpApi();
  final storage = GetStorage();
  Future<dynamic> signUp1(
      int userId,
      String vendorName,
      String ownerName,
      int vendorId,
      int contact,
      String address,
      String gstNumber,
      int pincode,
      String state,
      String district,
      String locality,
      double lattitude,
      double longitude,
      String registerDate) async {
    try {
      final response = await _signUpApi.signUp(
          userId,
          vendorName,
          ownerName,
          vendorId,
          contact,
          address,
          gstNumber,
          pincode,
          state,
          district,
          locality,
          lattitude,
          longitude,
          registerDate);
      print("res= $response");
      if (response["message"] == "Success") {
        SignupModel? userlogin = SignupModel.fromJson(response);
        return userlogin;
      } else {
        throw response["errmessage"];
      }
    } on NetworkException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<VendorTypeModel> getType(String currentValue, String type) async {
    try {
      final response = await _signUpApi.getDropDownData(currentValue, type);

      if (response["message"] == "Success") {
        VendorTypeModel? dropDownData = VendorTypeModel.fromJson(response);

        return dropDownData;
      } else if (response["message"] != "Success") {
        throw response["message"];
      } else {
        throw response["errmessage"];
      }
    } on NetworkException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<SignupModel> vendorSignUp(
      File cropped,
      int userId,
      String vendorName,
      String ownerName,
      int vendorId,
      int contact,
      String address,
      String gstNumber,
      int pincode,
      String state,
      String district,
      String locality,
      double lattitude,
      double longitude,
      String registerDate,
      File image) async {
    var postUri = Uri.parse(ApiConstants.baseUrl + ApiConstants.vendorSignUp);
    var request = http.MultipartRequest("POST", postUri);

    request.fields['user_id'] = userId.toString();
    request.fields['vendor_name'] = vendorName;
    request.fields['owner_name'] = ownerName;
    request.fields['contact1'] = contact.toString();
    request.fields['address'] = address;
    request.fields['registration_date'] = registerDate;
    request.fields['vendor_type_id'] = vendorId.toString();
    request.fields['latitude'] = lattitude.toString();
    request.fields['longitude'] = longitude.toString();
    request.fields['pincode'] = pincode.toString();
    request.fields['state'] = state;
    request.fields['district'] = district;
    request.fields['locality'] = locality;
    request.fields['gst_number'] = gstNumber;
    print("request=${request.fields}");
    String token = "";
    token = storage.read("token") == null || storage.read("token") == ""
        ? ""
        : storage.read("token");
    Map<String, String> headers = {
      "content-Type'": "multipart/form-data",
      "Authorization": "Bearer " + token
    };
    request.headers.addAll(headers);

    var imagebyte = await cropped.readAsBytes();
    List<int> list = imagebyte.cast();
    request.files.add(http.MultipartFile.fromBytes('thumbnail_image', list,
        filename: cropped.path));

    var imagebytes = await image.readAsBytes();
    List<int> listData = imagebytes.cast();
    request.files.add(http.MultipartFile.fromBytes('document_upload', listData,
        filename: image.path));

    print("request = ${request.files}");
    var response = await request.send();
    print("response --=${response.statusCode}");
    final resp = await http.Response.fromStream(response);
    print("response --=${resp.body}");
    var responseJson = jsonDecode(resp.body);
    if (response.statusCode == 200) {
      print("response=$responseJson");
      print("sssh=${responseJson["data"]["vendor name"]}");
      storage.write("vendorName", responseJson["data"]["vendor name"]);
      storage.write("ownerName", responseJson["data"]["owner name"]);
      if (responseJson["message"] == "Success") {
        SignupModel? signupModel = SignupModel.fromJson(responseJson);
        return signupModel;
      } else {
        throw responseJson["message"];
      }
    } else {
      throw responseJson["message"];
    }
  }
}
