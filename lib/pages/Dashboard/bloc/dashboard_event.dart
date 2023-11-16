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

class FetchBrand extends DashboardEvent {
  const FetchBrand();
}

class FetchYourCategory extends DashboardEvent {
  final int vendorId;
  const FetchYourCategory(this.vendorId);
}

class DeleteCategory extends DashboardEvent {
  final int vendorId;
  final int categoryIds;
  const DeleteCategory(this.vendorId, this.categoryIds);
}
