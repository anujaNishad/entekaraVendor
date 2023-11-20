part of 'edit_profile_bloc.dart';

abstract class ProfileState {
  ProfileState();
}

class ProfileInitial extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  ProfileModel? profileData;
  ProfileLoadedState(this.profileData);
}

class ErrorState extends ProfileState {
  String error;
  ErrorState(this.error);
}

class ProfileLoadingState extends ProfileState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
