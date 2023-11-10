import 'package:entekaravendor/constants/api_constatnt.dart';
import 'package:entekaravendor/services/base_api.dart';

class ProductApi extends CoreApi {
  Future<dynamic> getProductDetails(int vendorId, String search) async {
    const url = ApiConstants.vendorProduct;
    final body = {
      "vendor_id": vendorId,
      "search": search,
    };

    return await post(url, body);
  }

  Future<dynamic> getProductVariant(int productId) async {
    const url = ApiConstants.vendorProductVariant;
    final body = {"product_id": productId};
    return await post(url, body);
  }

  Future<dynamic> addProductVariant(int vendorId, int productId, int variantId,
      dynamic price, dynamic discount) async {
    const url = ApiConstants.addVendorProductVariant;
    final body = {
      "vendor_id": vendorId,
      "product_id": productId,
      "variant_id": variantId,
      "price": price,
      "discount": discount
    };

    return await post(url, body);
  }

  Future<dynamic> getProductItem(int vendorId, String search) async {
    const url = ApiConstants.vendorProductVariantItem;
    final body = {"vendor_id": vendorId, "search": search};

    return await post(url, body);
  }

  Future<dynamic> updateProductItem(int vendor_productId, int vendorId,
      int productId, int variantId, dynamic price, dynamic discount) async {
    const url = ApiConstants.updateProductVariantItem;
    final body = {
      "vendor_product_id": vendor_productId,
      "vendor_id": vendorId,
      "product_id": productId,
      "variant_id": variantId,
      "price": price,
      "discount": discount
    };

    return await post(url, body);
  }

  Future<dynamic> getBrand() async {
    const url = ApiConstants.vendorBrands;
    return await get(url);
  }
}
