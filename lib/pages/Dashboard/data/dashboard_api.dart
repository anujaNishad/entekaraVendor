import 'package:entekaravendor/constants/api_constatnt.dart';
import 'package:entekaravendor/services/base_api.dart';

class DashboardApi extends CoreApi {
  Future<dynamic> getCategory(int vendorId) async {
    const url = ApiConstants.vendorcategory;
    final body = {"vendor_id": vendorId};
    return await post(url, body);
  }

  Future<dynamic> updateCategory(
      int vendorId, List<dynamic> categoryIds) async {
    const url = ApiConstants.updateVendorCategory;
    Map<String, dynamic> valuesArray = {
      for (int i = 0; i < categoryIds.length; i++)
        "category_ids[$i]": categoryIds[i]
    };
    final body = {
      "vendor_id": vendorId,
      ...valuesArray,
    };
    print("bodyhhhj=$body");
    return await post(url, body);
  }
}
