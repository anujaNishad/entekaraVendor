import 'package:dio/dio.dart';
import 'package:entekaravendor/model/brand_model.dart';
import 'package:entekaravendor/model/category_model.dart';
import 'package:entekaravendor/model/updateCategory_model.dart';
import 'package:entekaravendor/model/your_category_model.dart';
import 'package:entekaravendor/pages/Dashboard/data/dashboard_api.dart';
import 'package:entekaravendor/services/failure.dart';
import 'package:get_storage/get_storage.dart';

import '../../../model/delete_category_model.dart';

class DashboardRepository {
  final Dio _dio = Dio();
  final storage = GetStorage();
  final DashboardApi _dashboardApi = DashboardApi();

  Future<CategoryModel> getCategory(int vendorId) async {
    try {
      final response = await _dashboardApi.getCategory(vendorId);
      if (response["message"] == "Success") {
        CategoryModel? categoryData = CategoryModel.fromJson(response);
        return categoryData;
      } else if (response["message"] != "Success") {
        throw response["message"];
      } else {
        throw response["errmessage"];
      }
    } on NetworkException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<UpdateCategoryModel?> updateCategory(
      int vendorId, List<dynamic> categoryIds) async {
    try {
      final response =
          await _dashboardApi.updateCategory(vendorId, categoryIds);
      UpdateCategoryModel? userlogin = UpdateCategoryModel.fromJson(response);
      return userlogin;
    } on NetworkException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getBrandDetails() async {
    try {
      final response = await _dashboardApi.getBrand();
      print("response = $response");
      BrandModel? userlogin = BrandModel.fromJson(response);

      return userlogin;
    } on NetworkException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<YourCategoryModel> getYourCategory(int vendorId) async {
    try {
      final response = await _dashboardApi.getYourCategory(vendorId);
      if (response["message"] == "Success") {
        YourCategoryModel? categoryData = YourCategoryModel.fromJson(response);
        return categoryData;
      } else if (response["message"] != "Success") {
        throw response["message"];
      } else {
        throw response["errmessage"];
      }
    } on NetworkException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<DeleteCategoryModel> deleteCategory(
      int vendorId, int categoryId) async {
    try {
      final response = await _dashboardApi.deleteCategory(vendorId, categoryId);
      if (response["message"] == "Sucess") {
        DeleteCategoryModel? categoryData =
            DeleteCategoryModel.fromJson(response);
        return categoryData;
      } else if (response["message"] != "Sucess") {
        throw response["message"];
      } else {
        throw response["errmessage"];
      }
    } on NetworkException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
