import 'package:entekaravendor/constants/api_constatnt.dart';
import 'package:entekaravendor/services/base_api.dart';

class ManageTimingApi extends CoreApi {
  Future<dynamic> getWorkingDays() async {
    const url = ApiConstants.workingDays;
    return await get(url);
  }

  Future<dynamic> addWorkingHours(
      int vendorId, int dayId, String opening_time, String closing_time) async {
    const url = ApiConstants.addManageTime;
    final body = {
      "vendor_id": vendorId,
      "day_id": dayId,
      "opening_time": opening_time,
      "closing_time": closing_time,
    };

    return await post(url, body);
  }
}
