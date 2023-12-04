import 'package:entekaravendor/model/status_model.dart';
import 'package:entekaravendor/pages/splash_screen/data/splash_api.dart';
import 'package:entekaravendor/services/failure.dart';
import 'package:get_storage/get_storage.dart';

class SplashRepository {
  final SplashApi _splashApi = SplashApi();
  final storage = GetStorage();

  Future<StatusModel> getStatusDetails(String phoneNumber) async {
    try {
      final response = await _splashApi.getStatus(phoneNumber);
      if (response["message"] == "Success") {
        StatusModel? userlogin = StatusModel.fromJson(response);
        return userlogin;
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
