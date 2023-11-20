part of 'edit_profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchProfile extends ProfileEvent {
  final int vendorId;
  const FetchProfile(this.vendorId);
}
