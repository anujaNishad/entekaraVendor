part of 'dashboard_bloc.dart';

abstract class DashboardState {
  DashboardState();
}

class DashboardInitial extends DashboardState {}

class CategoryLoadedState extends DashboardState {
  CategoryModel? categoryList;
  CategoryLoadedState(this.categoryList);
}

class ErrorState extends DashboardState {
  String error;
  ErrorState(this.error);
}

class CategoryLoadingState extends DashboardState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UpdateCategoryLoadedState extends DashboardState {
  UpdateCategoryModel updateCategory;
  UpdateCategoryLoadedState(this.updateCategory);
}
