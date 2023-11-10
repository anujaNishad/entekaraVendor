part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class FetchCategory extends DashboardEvent {
  final int vendorId;
  const FetchCategory(this.vendorId);
}

class UpdateCategory extends DashboardEvent {
  final int vendorId;
  final List<dynamic> categoryIds;
  const UpdateCategory(this.vendorId, this.categoryIds);
}
