import 'package:entekaravendor/model/status_model.dart';
import 'package:entekaravendor/pages/splash_screen/data/splash_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SplashRepository _authrepo = SplashRepository();
  SplashBloc() : super(StatusInitial()) {
    on<CheckAuthEvent>((event, emit) async {
      // loader = true;
      emit(const SplashState(loading: true));
      try {
        StatusModel statusModel =
            await _authrepo.getStatusDetails(event.phoneNumber);
        emit(SplashState(loading: false, statusData: statusModel));
      } catch (e) {
        emit(ErrorState(false, e.toString()));
      }
    });
  }
}
