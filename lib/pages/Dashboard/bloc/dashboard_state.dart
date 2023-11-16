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

class BrandLoadedState extends DashboardState {
  BrandModel? brandData;
  BrandLoadedState(this.brandData);
}

class BrandLoadingState extends DashboardState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class YourCategoryLoadedState extends DashboardState {
  YourCategoryModel? categoryDataList;
  YourCategoryLoadedState(this.categoryDataList);
}

class DeleteCategoryLoadedState extends DashboardState {
  DeleteCategoryModel? categoryDataList;
  DeleteCategoryLoadedState(this.categoryDataList);
}
