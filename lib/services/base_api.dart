import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:entekaravendor/constants/api_constatnt.dart';
import 'package:get_storage/get_storage.dart';

import 'netwrok_exceptions.dart';

class CoreApi {
  final Dio _dio = Dio();
  final storage = GetStorage();

  Future<dynamic> get(
    String api,
  ) async {
    print("hbjjh=${storage.read("token")}");
    String token = "";
    token = storage.read("token") == null || storage.read("token") == ""
        ? ""
        : storage.read("token");

    //token = await SharedPreference().gettoken();
    _dio.options.headers['content-Type'] = 'multipart/form-data';
    _dio.options.headers["authorization"] = "Bearer $token";
    _dio.options.headers['Accept'] = 'application/json';
    try {
      final response = await _dio.get(
        ApiConstants.baseUrl + api,
      );
      print(response.data);
      return _parseResponse(response);
    } on DioException catch (e) {
      print("exception get=${e.response!.statusCode}");
      print("exception get=${e.response}");
      var res = e.response;
      switch (res!.statusCode) {
        case 204:
          throw "No content available";
        case 401:
          throw e.response!.data["error"];
        case 404:
          throw "Item not found";
        case 500:
          throw "Internal server error";
        default:
          throw e.response!.data["error"];
      }
    } catch (e) {
      throw "An error occurred: $e";
    }
  }

  Future<dynamic> post(
    String api,
    Map<String, dynamic> body,
  ) async {
    print(body);
    print(api);
    String token = "";
    token = storage.read("token") == null || storage.read("token") == ""
        ? ""
        : storage.read("token");
    //token = await SharedPreference().gettoken();
    _dio.options.headers['content-Type'] = 'multipart/form-data';
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer $token";

    try {
      FormData formData = FormData.fromMap(body);
      final response = await _dio.post(
        ApiConstants.baseUrl + api,
        data: formData,
      );
      print("response data=${response.data}");
      return _parseResponse(response);
    } on DioException catch (e) {
      print("exception post=${e.response}");
      var res = e.response;
      switch (res!.statusCode) {
        case 204:
          throw "No content available";
        case 401:
          throw e.response!.data["error"];
        case 404:
          throw "Item not found";
        case 500:
          throw "Internal server error";
        default:
          throw e.response!.data["message"];
      }
    } catch (e) {
      throw "An error occurred1: $e";
    }
  }

  dynamic _parseResponse(Response response) {
    if (response.data is Map<String, dynamic>) {
      return response.data;
    }
    print(response.data);
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.data);
      case 204:
        throw const NoContentException(
            statusCode: 204, errorMessage: "No content available");
      case 401:
        throw const NoContentException(
            statusCode: 401, errorMessage: "Unauthorised");
      case 404:
        throw const NotFoundException(
            statusCode: 404, errorMessage: "Item not found");
      default:
        throw const InternalServerError(
            statusCode: 500, errorMessage: "Internal server error");
    }
  }

  Future<dynamic> postNew(
    String api,
    Map<String, dynamic> body,
  ) async {
    print(body);
    print(api);
    String token = "";
    token = storage.read("token") == null || storage.read("token") == ""
        ? ""
        : storage.read("token");
    //token = await SharedPreference().gettoken();
    _dio.options.headers['content-Type'] = 'multipart/form-data';
    _dio.options.headers["authorization"] = "Bearer $token";

    try {
      FormData formData = FormData.fromMap(body);
      final response = await _dio.post(
        ApiConstants.baseUrl + api,
        data: formData,
      );
      print("response data=${response.data}");
      switch (response.statusCode) {
        case 200:
          {
            print("response.body=${response.data}");
          }
          return jsonDecode(response.data);
        case 204:
          throw const NoContentException(
              statusCode: 204, errorMessage: "No content available");
        case 404:
          throw const NotFoundException(
              statusCode: 404, errorMessage: "Item not found");
        default:
          throw const InternalServerError(
              statusCode: 500, errorMessage: "Internal server error");
      }
    } on DioException catch (e) {
      print("exception post=${e.response}");
      var res = e.response;
      switch (res!.statusCode) {
        case 204:
          throw "No content available";
        case 401:
          throw e.response!.data["error"];
        case 404:
          throw "Item not found";
        default:
          throw "Internal server error";
      }
    } catch (e) {
      throw "An error occurred1: $e";
    }
  }

  Future<dynamic> getNew1(
    String api,
  ) async {
    String token = "";
    token = storage.read("token") == null || storage.read("token") == ""
        ? ""
        : storage.read("token");

    //token = await SharedPreference().gettoken();
    _dio.options.headers['content-Type'] = 'multipart/form-data';
    _dio.options.headers["authorization"] = "Bearer $token";
    _dio.options.headers['Accept'] = 'application/json';
    try {
      final response = await _dio.get(
        ApiConstants.baseUrl + api,
      );
      print("res get=${response.data}");
      switch (response.statusCode) {
        case 200:
          return response.data;
        case 204:
          throw const NoContentException(
              statusCode: 204, errorMessage: "No content available");
        case 401:
          throw const NoContentException(
              statusCode: 401, errorMessage: "Unauthorised");
        case 404:
          throw const NotFoundException(
              statusCode: 404, errorMessage: "Item not found");
        default:
          throw const InternalServerError(
              statusCode: 500, errorMessage: "Internal server error");
      }
    } on DioException catch (e) {
      print("exception post=${e.response!.statusCode}");
      print("exception post=${e.response}");
      var res = e.response;
      switch (res!.statusCode) {
        case 204:
          throw "No content available";
        case 401:
          throw e.response!.data["error"];
        case 404:
          throw "Item not found";
        case 500:
          throw "Internal server error";
        default:
          throw e.response!.data["error"];
      }
    } catch (e) {
      throw "An error occurred: $e";
    }
  }
}
