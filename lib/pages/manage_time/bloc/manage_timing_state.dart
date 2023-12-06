part of 'manage_timing_bloc.dart';

abstract class ManageTimingState {
  ManageTimingState();
}

class ManageTimingInitial extends ManageTimingState {}

class DaysLoadedState extends ManageTimingState {
  DaysModel? dayData;
  DaysLoadedState(this.dayData);
}

class AddWorkingDaysLoadedState extends ManageTimingState {
  ManageTimeModel? productData;
  AddWorkingDaysLoadedState(this.productData);
}

class ErrorState extends ManageTimingState {
  String error;
  ErrorState(this.error);
}

class ManageTimingLoadingState extends ManageTimingState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetWorkingLoadedState extends ManageTimingState {
  GetManageTimeModel? manageTimeModel;
  GetWorkingLoadedState(this.manageTimeModel);
}

class DeleteWorkingDaysLoadedState extends ManageTimingState {
  MessageModel? deleteData;
  DeleteWorkingDaysLoadedState(this.deleteData);
}

class UpdateWorkingDaysLoadedState extends ManageTimingState {
  ManageTimeModel? updateData;
  UpdateWorkingDaysLoadedState(this.updateData);
}
