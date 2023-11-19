import 'package:entekaravendor/model/day_model.dart';
import 'package:entekaravendor/model/manage_time_model.dart';
import 'package:entekaravendor/pages/manage_time/data/manage_timing_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'manage_timing_event.dart';
part 'manage_timing_state.dart';

class ManageTimingBloc extends Bloc<ManageTimingEvent, ManageTimingState> {
  final ManageTimingRepository _manageTimingRepository =
      ManageTimingRepository();

  ManageTimingBloc() : super(ManageTimingInitial()) {
    on<FetchDays>((event, emit) async {
      try {
        emit(ManageTimingLoadingState());
        DaysModel dayList = await _manageTimingRepository.getWorkingDays();
        emit(DaysLoadedState(dayList));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
    on<AddWorkingDays>((event, emit) async {
      try {
        emit(ManageTimingLoadingState());
        ManageTimeModel dayList = await _manageTimingRepository.addWorkingDays(
            event.vendorId, event.dayId, event.openTime, event.closeTime);
        emit(AddWorkingDaysLoadedState(dayList));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
  }
}
