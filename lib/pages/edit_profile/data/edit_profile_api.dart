import 'package:entekaravendor/constants/api_constatnt.dart';
import 'package:entekaravendor/services/base_api.dart';

class ProfileApi extends CoreApi {
  Future<dynamic> getProfileDetails(int vendorId) async {
    const url = ApiConstants.profileDetails;
    final body = {"vendor_id": vendorId};
    return await post(url, body);
  }
}
