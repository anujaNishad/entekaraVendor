import 'package:entekaravendor/model/login_model.dart';
import 'package:entekaravendor/model/verifyOTP_model.dart';
import 'package:entekaravendor/pages/vendor_login/data/login_api.dart';
import 'package:entekaravendor/services/failure.dart';

class LoginRepository {
  final LoginApi _loginApi = LoginApi();

  Future<LoginModel> sendOtp(int phone) async {
    try {
      final response = await _loginApi.sendOtp(phone);

      LoginModel? userlogin = LoginModel.fromJson(response);
      return userlogin;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<VerifyOtpModel> verifyOtp(int otp, int phone) async {
    try {
      final response = await _loginApi.verifyOtp(otp, phone);
      if (response["message"] == "Success") {
        VerifyOtpModel? userlogin = VerifyOtpModel.fromJson(response);
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
