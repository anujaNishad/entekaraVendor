part of 'manage_timing_bloc.dart';

abstract class ManageTimingEvent extends Equatable {
  const ManageTimingEvent();

  @override
  List<Object> get props => [];
}

class FetchDays extends ManageTimingEvent {
  const FetchDays();
}

class AddWorkingDays extends ManageTimingEvent {
  final int vendorId;
  final int dayId;
  final String openTime;
  final String closeTime;
  const AddWorkingDays(
      this.vendorId, this.dayId, this.closeTime, this.openTime);
}
