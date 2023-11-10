part of 'loading_bloc.dart';

class LoginState {
  bool isFetching;
  bool loginSuccess;
  bool validate;
  VerifyOtpModel? logindata;
  String errorMessage;

  LoginState(
      {this.errorMessage = "",
      required this.isFetching,
      required this.loginSuccess,
      this.logindata,
      this.validate = false});
}

class LoginInitial extends LoginState {
  LoginInitial() : super(isFetching: false, loginSuccess: false);
}

class LoginResposne extends LoginState {
  LoginResposne() : super(isFetching: true, loginSuccess: false);
}

class SendOtpSuccess extends LoginState {
  SendOtpSuccess() : super(isFetching: true, loginSuccess: false);
}

class ValidateForm extends LoginState {
  ValidateForm()
      : super(isFetching: false, loginSuccess: false, validate: true);
}

class ErrorState extends LoginState {
  ErrorState(
      {required super.errorMessage,
      required super.isFetching,
      required super.loginSuccess});
}

class LoadedState extends LoginState {
  LoadedState(
      {required super.logindata,
      required super.isFetching,
      required super.loginSuccess,
      required super.errorMessage});
}
