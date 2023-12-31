import 'package:dio/dio.dart';
import 'package:entekaravendor/model/GetManageTimeModel.dart';
import 'package:entekaravendor/model/day_model.dart';
import 'package:entekaravendor/model/manage_time_model.dart';
import 'package:entekaravendor/model/message_model.dart';
import 'package:entekaravendor/pages/manage_time/data/manage_timing_api.dart';
import 'package:entekaravendor/services/failure.dart';
import 'package:get_storage/get_storage.dart';

class ManageTimingRepository {
  final ManageTimingApi _manageTimingApi = ManageTimingApi();
  final Dio _dio = Dio();
  final storage = GetStorage();

  Future<DaysModel> getWorkingDays() async {
    try {
      final response = await _manageTimingApi.getWorkingDays();
      if (response["message"] == "Success") {
        DaysModel? userlogin = DaysModel.fromJson(response);
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

  Future<ManageTimeModel> addWorkingDays(int vendorId, int dayId,
      String openTime, String closeTime, String status) async {
    try {
      final response = await _manageTimingApi.addWorkingHours(
          vendorId, dayId, openTime, closeTime, status);
      if (response["message"] == "Success") {
        ManageTimeModel? userlogin = ManageTimeModel.fromJson(response);
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

  Future<GetManageTimeModel> getWorkingDetails(int vendorId) async {
    try {
      final response = await _manageTimingApi.getWorkingDetails(vendorId);
      if (response["message"] == "Success") {
        GetManageTimeModel? getManageTimeModel =
            GetManageTimeModel.fromJson(response);
        return getManageTimeModel;
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

  Future<MessageModel> deleteWorkingDetails(int vendorId, int hourId) async {
    try {
      final response =
          await _manageTimingApi.deleteWorkingDetails(vendorId, hourId);
      MessageModel? getManageTimeModel = MessageModel.fromJson(response);
      return getManageTimeModel;
    } on NetworkException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<ManageTimeModel> updateWorkingDays(int hourId, int vendorId, int dayId,
      String openTime, String closeTime, String status) async {
    try {
      final response = await _manageTimingApi.updateWorkingHours(
          hourId, vendorId, dayId, openTime, closeTime, status);
      if (response["message"] == "Success") {
        ManageTimeModel? userlogin = ManageTimeModel.fromJson(response);
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
