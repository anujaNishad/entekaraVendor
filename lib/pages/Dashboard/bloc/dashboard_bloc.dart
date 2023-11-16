import 'package:entekaravendor/model/brand_model.dart';
import 'package:entekaravendor/model/category_model.dart';
import 'package:entekaravendor/model/delete_category_model.dart';
import 'package:entekaravendor/model/updateCategory_model.dart';
import 'package:entekaravendor/model/your_category_model.dart';
import 'package:entekaravendor/pages/Dashboard/data/dashboard_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository _dashboardRepository = DashboardRepository();
  DashboardBloc() : super(DashboardInitial()) {
    on<FetchCategory>((event, emit) async {
      try {
        emit(CategoryLoadingState());

        CategoryModel categoryList =
            await _dashboardRepository.getCategory(event.vendorId);
        emit(CategoryLoadedState(categoryList));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });

    on<UpdateCategory>((event, emit) async {
      try {
        emit(CategoryLoadingState());
        print("vendor =${event.vendorId}");
        print("vendor =${event.categoryIds}");
        UpdateCategoryModel? categoryList = await _dashboardRepository
            .updateCategory(event.vendorId, event.categoryIds);
        emit(UpdateCategoryLoadedState(categoryList!));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
    on<FetchBrand>((event, emit) async {
      try {
        emit(BrandLoadingState());
        BrandModel? brandList = await _dashboardRepository.getBrandDetails();
        emit(BrandLoadedState(brandList));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
    on<FetchYourCategory>((event, emit) async {
      try {
        emit(CategoryLoadingState());

        YourCategoryModel categoryList =
            await _dashboardRepository.getYourCategory(event.vendorId);
        emit(YourCategoryLoadedState(categoryList));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });

    on<DeleteCategory>((event, emit) async {
      try {
        emit(CategoryLoadingState());

        DeleteCategoryModel categoryList = await _dashboardRepository
            .deleteCategory(event.vendorId, event.categoryIds);
        emit(DeleteCategoryLoadedState(categoryList));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
  }
}
