import 'package:entekaravendor/model/category_model.dart';
import 'package:entekaravendor/model/updateCategory_model.dart';
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
  }
}
