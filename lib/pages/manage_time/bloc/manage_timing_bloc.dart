import 'package:entekaravendor/model/GetManageTimeModel.dart';
import 'package:entekaravendor/model/day_model.dart';
import 'package:entekaravendor/model/manage_time_model.dart';
import 'package:entekaravendor/model/message_model.dart';
import 'package:entekaravendor/pages/manage_time/data/manage_timing_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'manage_timing_event.dart';
part 'manage_timing_state.dart';

class ManageTimingBloc extends Bloc<ManageTimingEvent, ManageTimingState> {
  final ManageTimingRepository _manageTimingRepository =
      ManageTimingRepository();

  ManageTimingBloc()
      : super(ManageTimingInitial(isButton: false, isFetching: false)) {
    on<FetchDays>((event, emit) async {
      try {
        emit(ManageTimingLoadingState(isButton: false, isFetching: false));
        DaysModel dayList = await _manageTimingRepository.getWorkingDays();
        emit(DaysLoadedState(dayList));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
    on<AddWorkingDays>((event, emit) async {
      try {
        emit(ManageTimingLoadingState(isButton: false, isFetching: false));
        ManageTimeModel dayList = await _manageTimingRepository.addWorkingDays(
            event.vendorId,
            event.dayId,
            event.openTime,
            event.closeTime,
            event.status);
        emit(AddWorkingDaysLoadedState(dayList));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });

    on<GetManageData>((event, emit) async {
      try {
        emit(ManageTimingLoadingState(isFetching: false, isButton: false));
        GetManageTimeModel manageData =
            await _manageTimingRepository.getWorkingDetails(event.vendorId);

        var length = manageData.data!.length;
        bool isButton = false;
        if (length == 7) {
          isButton = true;
        } else {
          isButton = false;
        }
        if (manageData.data!.length > 0) {
          emit(ManageTimingState(
              isFetching: false,
              isButton: isButton,
              manageTimeModel: manageData));
        } else {
          emit(ManageTimingLoadingState(isFetching: false, isButton: false));
        }
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });

    on<UpdateWorkingDays>((event, emit) async {
      try {
        emit(ManageTimingLoadingState(isButton: false, isFetching: false));
        ManageTimeModel updateList =
            await _manageTimingRepository.updateWorkingDays(
                event.hoursId,
                event.vendorId,
                event.dayId,
                event.openTime,
                event.closeTime,
                event.status);
        emit(UpdateWorkingDaysLoadedState(updateList));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
    on<DeleteWorkingDays>((event, emit) async {
      try {
        emit(ManageTimingLoadingState(isButton: false, isFetching: false));
        MessageModel updateList = await _manageTimingRepository
            .deleteWorkingDetails(event.vendorId, event.hourid);
        emit(DeleteWorkingDaysLoadedState(updateList));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
  }
}
