import 'package:entekaravendor/constants/api_constatnt.dart';
import 'package:entekaravendor/services/base_api.dart';

class ManageTimingApi extends CoreApi {
  Future<dynamic> getWorkingDays() async {
    const url = ApiConstants.workingDays;
    return await get(url);
  }

  Future<dynamic> addWorkingHours(int vendorId, int dayId, String opening_time,
      String closing_time, String status) async {
    const url = ApiConstants.addManageTime;
    final body = {
      "vendor_id": vendorId,
      "day_id": dayId,
      "opening_time": opening_time,
      "closing_time": closing_time,
      "status": status
    };

    return await post(url, body);
  }

  Future<dynamic> getWorkingDetails(int vendorId) async {
    const url = ApiConstants.getWorkingDetails;
    final body = {"vendor_id": vendorId};

    return await post(url, body);
  }

  Future<dynamic> deleteWorkingDetails(int vendorId, int hour_id) async {
    const url = ApiConstants.deleteWorkingDetails;
    final body = {"vendor_id": vendorId, "hour_id": hour_id};

    return await post(url, body);
  }

  Future<dynamic> updateWorkingHours(int hourId, int vendorId, int dayId,
      String opening_time, String closing_time, String status) async {
    const url = ApiConstants.updateWorkingDetails;
    final body = {
      "hour_id": hourId,
      "vendor_id": vendorId,
      "day_id": dayId,
      "opening_time": opening_time,
      "closing_time": closing_time,
      "status": status
    };

    return await post(url, body);
  }
}
