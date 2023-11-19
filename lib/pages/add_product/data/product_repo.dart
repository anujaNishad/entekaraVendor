import 'package:dio/dio.dart';
import 'package:entekaravendor/model/AddProductVariantModel.dart';
import 'package:entekaravendor/model/delete_product_model.dart';
import 'package:entekaravendor/model/productVarientModel.dart';
import 'package:entekaravendor/model/product_model.dart';
import 'package:entekaravendor/model/productdetails_model.dart';
import 'package:entekaravendor/model/updateproductitem_model.dart';
import 'package:entekaravendor/pages/add_product/data/product_api.dart';
import 'package:entekaravendor/services/failure.dart';
import 'package:get_storage/get_storage.dart';

class ProductRepository {
  final ProductApi _productApi = ProductApi();
  final Dio _dio = Dio();
  final storage = GetStorage();
  Future<ProductModel> getProductDetails(int vendorID, String search) async {
    try {
      final response = await _productApi.getProductDetails(vendorID, search);
      if (response["message"] == "Success") {
        ProductModel? userlogin = ProductModel.fromJson(response);
        return userlogin;
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

  Future<dynamic> getProductVariant(int productId) async {
    try {
      final response = await _productApi.getProductVariant(productId);
      ProductVarientModel? userlogin = ProductVarientModel.fromJson(response);
      return userlogin;
    } on NetworkException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> addProductVariant(int vendorId, int productId, int variantId,
      dynamic price, dynamic discount) async {
    try {
      final response = await _productApi.addProductVariant(
          vendorId, productId, variantId, price, discount);
      if (response["message"] == "Variant id is already exists for vendor") {
        throw response["message"];
      } else if (response["vendor_id"] != "") {
        AddProductVarientModel? userlogin =
            AddProductVarientModel.fromJson(response);
        return userlogin;
      } else {
        throw response["errmessage"];
      }
    } on NetworkException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getProductItem(int vendorId, String search) async {
    try {
      final response = await _productApi.getProductItem(vendorId, search);
      if (response["message"] == "Success") {
        ProductDetailsModel? userlogin = ProductDetailsModel.fromJson(response);
        return userlogin;
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

  Future<dynamic> updateProductItem(int vendor_productId, int vendorId,
      int productId, int variantId, dynamic price, dynamic discount) async {
    try {
      final response = await _productApi.updateProductItem(
          vendor_productId, vendorId, productId, variantId, price, discount);
      print("response = $response");
      UpdateProductItemModel? userlogin =
          UpdateProductItemModel.fromJson(response);

      return userlogin;
    } on NetworkException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductModel?> fetchFilterProduct(int vendorId, String search,
      List<dynamic> categoryIds, List<dynamic> brandIds) async {
    try {
      final response = await _productApi.fetchFilterCategory(
          vendorId, search, categoryIds, brandIds);
      if (response["message"] == "Success") {
        ProductModel? userlogin = ProductModel.fromJson(response);
        return userlogin;
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

  Future<ProductDetailsModel?> fetchFilterProductVariant(int vendorId,
      String search, List<dynamic> categoryIds, List<dynamic> brandIds) async {
    try {
      final response = await _productApi.fetchFilterProductVariant(
          vendorId, search, categoryIds, brandIds);
      if (response["message"] == "Success") {
        ProductDetailsModel? userlogin = ProductDetailsModel.fromJson(response);
        return userlogin;
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

  Future<DeleteProductModel?> deleteProductVariantItem(
      int vendor_productId, int vendorId) async {
    try {
      final response = await _productApi.deleteProductItemVariant(
          vendor_productId, vendorId);
      if (response["message"] == "Success") {
        DeleteProductModel? userlogin = DeleteProductModel.fromJson(response);
        return userlogin;
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
}
