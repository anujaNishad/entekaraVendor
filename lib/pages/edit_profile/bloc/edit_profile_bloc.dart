import 'package:entekaravendor/model/profile_model.dart';
import 'package:entekaravendor/pages/edit_profile/data/edit_profile_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository = ProfileRepository();

  ProfileBloc() : super(ProfileInitial()) {
    on<FetchProfile>((event, emit) async {
      try {
        emit(ProfileLoadingState());
        ProfileModel profileData =
            await _profileRepository.getProfileDetails(event.vendorId);
        emit(ProfileLoadedState(profileData));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
  }
}
