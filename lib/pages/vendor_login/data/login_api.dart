import 'package:entekaravendor/constants/api_constatnt.dart';
import 'package:entekaravendor/services/base_api.dart';

class LoginApi extends CoreApi {
  Future<dynamic> sendOtp(int phone) async {
    const url = ApiConstants.login;
    final body = {
      "mobile": phone,
    };

    return await post(url, body);
  }

  Future<dynamic> verifyOtp(int otp, int phone) async {
    const url = ApiConstants.otpVerification;
    final body = {
      "otp": otp,
      "mobile": phone,
    };

    return await post(url, body);
  }
}
