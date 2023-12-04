part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthEvent extends SplashEvent {
  final String phoneNumber;
  const CheckAuthEvent(this.phoneNumber);
}
