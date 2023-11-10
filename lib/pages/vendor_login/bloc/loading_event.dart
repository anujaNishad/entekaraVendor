part of 'loading_bloc.dart';

class LoginEvent {}

class UserLoginEvent extends LoginEvent {
  final int phoneNumber;
  UserLoginEvent(this.phoneNumber);
}

class VerifyOtpEvent extends LoginEvent {
  final int otp;
  final int phoneNumber;

  VerifyOtpEvent(this.otp, this.phoneNumber);
}

class ValidteFormEvent extends LoginEvent {
  ValidteFormEvent();
}
