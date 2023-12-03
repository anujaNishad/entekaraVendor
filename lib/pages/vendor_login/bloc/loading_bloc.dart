import 'package:entekaravendor/model/login_model.dart';
import 'package:entekaravendor/model/verifyOTP_model.dart';
import 'package:entekaravendor/pages/vendor_login/data/login_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

part 'loading_event.dart';
part 'loading_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository = LoginRepository();
  final storage = GetStorage();
  LoginBloc() : super(LoginInitial()) {
    on<ValidteFormEvent>((event, emit) => emit(ValidateForm()));

    on<UserLoginEvent>((event, emit) async {
      try {
        emit(LoginState(isFetching: true, loginSuccess: false));
        LoginModel loginData =
            await _loginRepository.sendOtp(event.phoneNumber);
        print("loginData =$loginData");
        if (loginData.otp != 0) {
          emit(SendOtpSuccess());
        } else {
          emit(ErrorState(
              errorMessage: "OTP failed try again !!",
              isFetching: false,
              loginSuccess: false));
        }
      } catch (e) {
        emit(ErrorState(
            errorMessage: e.toString(),
            isFetching: false,
            loginSuccess: false));
      }
    });

    on<VerifyOtpEvent>((event, emit) async {
      try {
        emit(LoginState(isFetching: true, loginSuccess: false));
        VerifyOtpModel data =
            await _loginRepository.verifyOtp(event.otp, event.phoneNumber);
        if (data.message == "Success") {
          print("sffgsgfsgs");
          storage.write("token", data.data!.token);
          storage.write("vendorId", data.data!.id);
          storage.write("vendorName", data.data!.vendorName);
          storage.write("ownerName", data.data!.ownerName);
          storage.write("mobile", data.data!.mobile);
          storage.write("thumbnail", data.data!.thumbnail);
          emit(LoadedState(
              isFetching: false,
              logindata: data,
              loginSuccess: true,
              errorMessage: ""));
        } else {
          emit(ErrorState(
              errorMessage: data.message!,
              isFetching: false,
              loginSuccess: false));
        }
      } catch (e) {
        emit(ErrorState(
            errorMessage: e.toString(),
            isFetching: false,
            loginSuccess: false));
      }
    });
  }
}
