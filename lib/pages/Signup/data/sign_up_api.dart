import 'package:entekaravendor/constants/api_constatnt.dart';

import '../../../../services/base_api.dart';

class SignUpApi extends CoreApi {
  Future<dynamic> signUp(
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
    const url = ApiConstants.vendorSignUp;
    final body = {
      "user_id": userId,
      "vendor_name": vendorName,
      "owner_name": ownerName,
      "contact1": contact,
      "address": address,
      "registration_date": registerDate,
      "vendor_type_id": vendorId,
      "latitude": lattitude,
      "longitude": longitude,
      "state": state,
      "pincode": pincode,
      "district": district,
      "locality": locality,
      "gst_number": gstNumber
      //thumbnail_image
    };

    return await post(url, body);
  }

  Future<dynamic> getDropDownData(String currentValue, String type) async {
    const url = ApiConstants.vendorType;
    return await get(url);
  }
}
