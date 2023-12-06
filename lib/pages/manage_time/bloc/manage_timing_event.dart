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
  final String status;
  const AddWorkingDays(
      this.vendorId, this.dayId, this.closeTime, this.openTime, this.status);
}

class GetManageData extends ManageTimingEvent {
  final int vendorId;
  const GetManageData(this.vendorId);
}

class DeleteWorkingDays extends ManageTimingEvent {
  final int vendorId;
  final int hourid;

  const DeleteWorkingDays(this.vendorId, this.hourid);
}

class UpdateWorkingDays extends ManageTimingEvent {
  final int hoursId;
  final int vendorId;
  final int dayId;
  final String openTime;
  final String closeTime;
  final String status;
  const UpdateWorkingDays(this.hoursId, this.vendorId, this.dayId,
      this.closeTime, this.openTime, this.status);
}
