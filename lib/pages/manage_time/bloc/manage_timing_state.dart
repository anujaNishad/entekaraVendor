part of 'manage_timing_bloc.dart';

class ManageTimingState {
  bool isFetching;
  bool isButton;
  GetManageTimeModel? manageTimeModel;

  ManageTimingState(
      {required this.isFetching, required this.isButton, this.manageTimeModel});
}

class ManageTimingInitial extends ManageTimingState {
  ManageTimingInitial({required super.isFetching, required super.isButton});
}

class DaysLoadedState extends ManageTimingState {
  DaysModel? dayData;

  DaysLoadedState(this.dayData) : super(isFetching: false, isButton: false);
}

class AddWorkingDaysLoadedState extends ManageTimingState {
  ManageTimeModel? productData;

  AddWorkingDaysLoadedState(this.productData)
      : super(isFetching: false, isButton: false);
}

class ErrorState extends ManageTimingState {
  String error;

  ErrorState(this.error) : super(isFetching: false, isButton: false);
}

class ManageTimingLoadingState extends ManageTimingState {
  ManageTimingLoadingState(
      {required super.isFetching, required super.isButton});

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetWorkingLoadedState extends ManageTimingState {
  GetWorkingLoadedState() : super(isFetching: false, isButton: false);
}

class DeleteWorkingDaysLoadedState extends ManageTimingState {
  MessageModel? deleteData;

  DeleteWorkingDaysLoadedState(this.deleteData)
      : super(isFetching: false, isButton: false);
}

class UpdateWorkingDaysLoadedState extends ManageTimingState {
  ManageTimeModel? updateData;

  UpdateWorkingDaysLoadedState(this.updateData)
      : super(isFetching: false, isButton: false);
}
