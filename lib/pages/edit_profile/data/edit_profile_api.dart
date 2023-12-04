import 'package:entekaravendor/constants/api_constatnt.dart';
import 'package:entekaravendor/services/base_api.dart';

class ProfileApi extends CoreApi {
  Future<dynamic> getProfileDetails(int vendorId) async {
    const url = ApiConstants.profileDetails;
    final body = {"vendor_id": vendorId};
    return await post(url, body);
  }

  Future<dynamic> editProfile(
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
      String email) async {
    const url = ApiConstants.editProfile;
    final body = {
      "user_id": userId,
      "vendor_name": vendorName,
      "owner_name": ownerName,
      "contact2": contact,
      "address": address,
      "registration_date": registerDate,
      "vendor_type_id": vendorId,
      "latitude": lattitude,
      "longitude": longitude,
      "state": state,
      "pincode": pincode,
      "district": district,
      "locality": locality,
      "gst_number": gstNumber,
      "email": email,
    };

    return await post(url, body);
  }
}
