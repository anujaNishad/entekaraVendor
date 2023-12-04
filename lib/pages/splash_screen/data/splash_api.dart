import 'package:entekaravendor/constants/api_constatnt.dart';
import 'package:entekaravendor/services/base_api.dart';

class SplashApi extends CoreApi {
  Future<dynamic> getStatus(String phoneNumber) async {
    const url = ApiConstants.getStatus;
    final body = {"mobile": phoneNumber};
    return await post(url, body);
  }
}
