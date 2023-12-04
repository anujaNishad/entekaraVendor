part of 'splash_bloc.dart';

class SplashState {
  final bool loading;
  final StatusModel? statusData;

  const SplashState({
    required this.loading,
    this.statusData,
  });
}

class StatusInitial extends SplashState {
  StatusInitial() : super(loading: false);
}

class StatusState extends SplashState {
  const StatusState() : super(loading: false);
}

class ErrorState extends SplashState {
  bool loading;
  String error;
  ErrorState(this.loading, this.error) : super(loading: false);
}
