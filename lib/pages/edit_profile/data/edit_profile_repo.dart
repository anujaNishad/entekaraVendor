import 'package:entekaravendor/model/profile_model.dart';
import 'package:entekaravendor/pages/edit_profile/data/edit_profile_api.dart';
import 'package:entekaravendor/services/failure.dart';

class ProfileRepository {
  final ProfileApi _profileApi = ProfileApi();

  Future<dynamic> getProfileDetails(int vendorId) async {
    try {
      final response = await _profileApi.getProfileDetails(vendorId);
      if (response["message"] == "Success") {
        ProfileModel? profileModel = ProfileModel.fromJson(response);
        return profileModel;
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
}
